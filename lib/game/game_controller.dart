import 'dart:ui';
import 'package:flappy_dash_ce/core/asset_manager.dart';
import 'package:flappy_dash_ce/core/base_game_loop.dart';
import 'package:flappy_dash_ce/core/size.dart';
import 'package:flappy_dash_ce/core/vibrate.dart';
import 'package:flappy_dash_ce/db/shared_preferences.dart';
import 'package:flappy_dash_ce/game/game_over_screen.dart';
import 'package:flappy_dash_ce/utils/constants.dart';
import 'package:flappy_dash_ce/core/box_collider.dart';
import 'package:flappy_dash_ce/core/game.dart';
import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/game/dash.dart';
import 'package:flappy_dash_ce/game/floor.dart';
import 'package:flappy_dash_ce/game/pipe.dart';
import 'package:flappy_dash_ce/game/pipe_generator.dart';
import 'package:flappy_dash_ce/game/point_collider.dart';
import 'package:flappy_dash_ce/game/points.dart';
import 'package:flappy_dash_ce/ui/button.dart';
import 'package:logger/logger.dart';

/// The GameController class manages the main game logic and state for the Flappy Dash game.
///
/// It handles the initialization of game objects, loading of assets, and the game loop,
/// including rendering and updating game objects and UI elements. The class also manages
/// game states such as starting, playing, and game over, and provides methods to restart
/// the game and calculate frames per second (FPS).
class GameController extends BaseGameLoop implements Game {
  late double fps;
  late int lastFrameTime;
  late bool showFPS;
  late double lastTime;
  late double timerToStart;
  late bool isScreenTouched;
  late GameState gameState;
  late List<GameObject> gameObjects;
  late List<GameObject> ui;
  late PipeGenerator? pipeGenerator;
  late Dash dash;
  late List<Floor> floors;
  late Points points;
  late Button restartButton;
  late Offset initialPos;
  late GameOverScreen gameOverScreen;
  late SharedPreferences sharedPreferences;
  late AssetManager assetManager;
  late VibrateController vibrateController;

  var logger = Logger();

  GameController({bool show = false}) {
    lastFrameTime = DateTime.now().millisecondsSinceEpoch;
    fps = 0.0;
    lastTime = 0.0;
    timerToStart = 0.0;
    showFPS = show;
    isScreenTouched = false;
    gameState = GameState.start;
    gameObjects = [];
    ui = [];
    initialPos = const Offset(50, 400);
    gameOverScreen = GameOverScreen(
      Size(SizeManager.instance.screen.width, SizeManager.instance.screen.height),
      const Offset(0, 0),
    );
    sharedPreferences = SharedPreferences();
    assetManager = AssetManager();
    vibrateController = VibrateController();
  }

  /// Loads game assets asynchronously and initializes game objects and UI elements.
  ///
  /// This method retrieves the best score from shared preferences and updates the
  /// points and game over screen with this score. It initializes the restart button
  /// with a specified size and position. The method also loads various sprites for
  /// game objects such as pipes, the floor, and the player character (Dash), and
  /// adds them to the game. Finally, it adds UI elements like the game over screen,
  /// points display, and restart button to the UI.
  @override
  Future<void> loadAssets() async {
    print(SizeManager.instance.screen.width);
    pipeGenerator = PipeGenerator(isAlive: true, obj: gameObjects);
    //***********
    points = Points(
      const Size(100, 100),
      Offset(SizeManager.instance.screen.width * 0.47, 70),
    );
    int bestScore = await sharedPreferences.load('bestScore') ?? 0;
    points.setGameState(gameState);
    points.setBestScore(bestScore);
    gameOverScreen.bestScore = bestScore;
    restartButton = Button(
      parentSize: Size(
        SizeManager.instance.screen.width * 0.35,
        SizeManager.instance.screen.height * 0.214,
      ),
      label: 'Restart',
      onTap: () {
        restart();
      },
      rect: Rect.fromLTWH(((SizeManager.instance.screen.width - 150) / 2) + 5, 115 + initialTop, 144, 42),
    );
    // ***********
    ui.add(gameOverScreen);
    ui.add(points);
    ui.add(restartButton);

    pipeGenerator!.setUpperSprite(assetManager.upperPipe);
    pipeGenerator!.setLowerSprite(assetManager.lowerPipe);
    print('screen: ${SizeManager.instance.screen.toString()}');
    gameObjects.addAll([
      Floor(
        assetManager.floor,
        Offset(0, SizeManager.instance.getFloorYPosition()),
        Size(SizeManager.instance.getFloorXPosition(), SizeManager.instance.getFloorHeight()),
      ),
      Floor(
        assetManager.floor,
        Offset(SizeManager.instance.getFloorXPosition(), SizeManager.instance.getFloorYPosition()),
        Size(SizeManager.instance.getFloorXPosition(), SizeManager.instance.getFloorHeight()),
      ),
      Floor(
        assetManager.floor,
        Offset(SizeManager.instance.getFloorXPosition() * 2, SizeManager.instance.getFloorYPosition()),
        Size(SizeManager.instance.getFloorXPosition(), SizeManager.instance.getFloorHeight()),
      ),
      dash = Dash(
        assetManager.dashSprite,
        Offset(SizeManager.instance.getDashInitialXPosition(), SizeManager.instance.getDashInitialYPosition()),
        const Size(56.8, 40),
        gameState,
      ),
    ]);
  }

  /// Initializes the game controller by loading assets and setting up the game state.
  @override
  void init() {
    loadAssets();
    assetManager.audioSettings.addBackgroundSongs([
      'sounds/bg-song2.mp3',
      'sounds/bg-song3.mp3',
      'sounds/bg-song1.mp3',
    ]);
    //assetManager.audioSettings.playBackgroundAudio();
  }

  /// Calculates and logs the current frames per second (FPS) of the game.
  ///
  /// This method computes the FPS by measuring the time difference between
  /// the current frame and the last frame. It updates the `fps` variable
  /// and logs the calculated FPS using the logger.
  @override
  void getFPS() {
    int currentFrameTime = DateTime.now().millisecondsSinceEpoch;
    int deltaTime = currentFrameTime - lastFrameTime;
    lastFrameTime = currentFrameTime;
    if (deltaTime > 0) {
      fps = (1000 / deltaTime);
    }
    logger.d('FPS: $fps');
  }

  /// Handles the game loop tick event, updating the game state based on the elapsed time.
  ///
  /// Calculates the time delta since the last tick and updates the timer for starting the game.
  /// If the screen is touched and the game is not over, it triggers the pipe generation.
  /// Also manages the removal of game objects and rendering of the UI and game objects.
  ///
  /// @param elapsedTime The duration since the game started.
  //@override
  void onTick2(Duration elapsedTime) {
    /*  final double dt = (elapsedTime.inMilliseconds - lastTime) / 1000;
    timerToStart += dt;
    lastTime = elapsedTime.inMilliseconds.toDouble();

    //avoid entering the game loop if the game already started
    if (isScreenTouched && elapsedTime.inMilliseconds > 1500 && gameState != GameState.gameOver) {
      if (pipeGenerator != null) {
        pipeGenerator!.generatePipes(dt);
      }
    }

    removeObjects();
    updateUI(dt);
    updateGameObjects(dt);
    if (showFPS) {
      getFPS();
    }*/
  }

  /// Handles the game over logic by updating the score and best score.
  ///
  /// Sets the game state to 'gameOver', updates the best score if the current
  /// score is higher, and saves it using shared preferences. Also updates the
  /// game state for the dash and points objects.
  @override
  void gameover() {
    vibrateController.vibrate();
    assetManager.audioSettings.stop();
    //play game over music
    gameOverScreen.score = points.record;
    if (points.bestScore < points.record) {
      gameOverScreen.bestScore = points.record;
      sharedPreferences.update('bestScore', points.record).then((v) => () {});
    }
    gameState = GameState.gameOver;
    dash.setGameState(gameState);
    points.setGameState(gameState);
  }

  /// Restarts the game if it is in the game over state.
  ///
  /// This method reinitializes the game by calling the `start` method and
  /// activates UI elements such as the game over screen and buttons by
  /// invoking their `awake` method.
  @override
  void restart() {
    if (gameState == GameState.gameOver) {
      assetManager.audioSettings.restartPlaylist();
      //assetManager.audioSettings.playBackgroundAudio();
      start();
      for (final uiElement in ui) {
        if (uiElement is GameOverScreen || uiElement is Button) {
          uiElement.awake();
        }
      }
    }
  }

  /// Renders and updates game objects based on the current game state.
  ///
  /// Iterates through all game objects, updating those that require it
  /// according to the game state. Specifically handles collision detection
  /// for the Dash object when the game is in the playing state, triggering
  /// a game over if Dash collides with a Pipe or Floor. Also updates the
  /// score when Dash passes a PointCollider.
  ///
  /// - Parameter deltaTime: The time elapsed since the last frame, used
  ///   for updating game object states.
  @override
  void updateGameObjects(double deltaTime) {
    for (final obj in gameObjects) {
      if (obj.shouldUpdate(gameState)) {
        obj.update(deltaTime);
      }
      if (obj is Dash && gameState == GameState.playing) {
        final collisions = BoxCollider.getCollision(obj, gameObjects);
        for (final other in collisions) {
          if (other is Pipe || other is Floor) {
            gameover();
            break;
          }
          if (other is PointCollider && !other.touched) {
            other.touched = true;
            points.record++;
          }
        }
      }
    }
  }

  /// Renders and updates UI elements based on the current game state.
  ///
  /// Iterates over all UI objects and updates them if they need to be
  /// updated or rendered according to the current game state.
  ///
  /// [deltaTime] The time elapsed since the last frame, used for updating
  /// the UI elements.
  @override
  void updateUI(double deltaTime) {
    for (final obj in ui) {
      if (obj.shouldUpdate(gameState) || obj.shouldRender(gameState)) {
        obj.update(deltaTime);
      }
    }
  }

  /// Removes game objects that are marked for deletion.
  @override
  void removeObjects() {
    gameObjects.removeWhere((obj) => obj.markedToDelete);
  }

  /// Initializes the game state and resets the game objects.
  @override
  void start() {
    isScreenTouched = false;
    gameState = GameState.start;
    timerToStart = 0;
    dash.awake();
    points.awake();
    pipeGenerator!.clearPipes();
  }

  bool isGameOver() {
    return gameState == GameState.gameOver;
  }

  /// Sets the game state to the specified state.
  @override
  void setGameState(GameState state) {
    gameState = state;
  }

  /// Sets the game state to 'playing' and triggers the Dash character to flap.
  @override
  void play() {
    isScreenTouched = true;
    gameState = GameState.playing;
    dash.isReadyToPlay = true;
    dash.flap();
  }

  @override
  void update(double dt) {
    timerToStart += dt;
    //avoid entering the game loop if the game already started
    if (isScreenTouched && timerToStart > 1.5 && gameState != GameState.gameOver) {
      if (pipeGenerator != null) {
        pipeGenerator!.generatePipes(dt);
      }
    }
    removeObjects();
    updateUI(dt);
    updateGameObjects(dt);
    if (showFPS) {
      getFPS();
    }
  }
}
