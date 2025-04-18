import 'package:flappy_dash_ce/core/box_collider.dart';
import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_painter.dart';
import 'package:flappy_dash_ce/game/floor.dart';
import 'package:flappy_dash_ce/game/game_over_screen.dart';
import 'package:flappy_dash_ce/game/pipe.dart' as p;
import 'package:flappy_dash_ce/game/pipe_generator.dart';
import 'package:flappy_dash_ce/game/points.dart';
import 'package:flappy_dash_ce/utils/sprite.dart';
import 'package:flappy_dash_ce/game/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logger/logger.dart';
import 'package:flappy_dash_ce/core/game_state.dart' as state;

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> with SingleTickerProviderStateMixin {
  List<GameObject> gameObjects = [];
  List<GameObject> ui = [];
  late Ticker ticker;
  late Dash dash;
  late List<Floor> floors;
  late Points points;
  double lastTime = 0.0;
  double flashBlackScreenTimer = 0;
  int lastFrameTime = DateTime.now().millisecondsSinceEpoch;
  double fps = 0.0;
  PipeGenerator? pipeGenerator;
  var logger = Logger();
  double timerToStart = 0;
  bool isScreenTouched = false;
  state.GameState gameState = state.GameState.start;

  void getFPS() {
    int currentFrameTime = DateTime.now().millisecondsSinceEpoch;
    int deltaTime = currentFrameTime - lastFrameTime;
    lastFrameTime = currentFrameTime;
    if (deltaTime > 0) {
      fps = (1000 / deltaTime);
    }
    logger.d('FPS: $fps');
  }

  void gameOver() {
    gameState = state.GameState.gameOver;
    ui.add(
      GameOverScreen(
        const Size(430, 900),
        const Offset(0, 0),
      ),
    );
    logger.d('GAME OVER');
  }

  void _onTick(Duration elapsed) {
    final double dt = (elapsed.inMilliseconds - lastTime) / 1000;
    timerToStart += dt;
    lastTime = elapsed.inMilliseconds.toDouble();
    if (isScreenTouched && elapsed.inSeconds > 2 && gameState != state.GameState.gameOver) {
      if (pipeGenerator != null) {
        pipeGenerator!.generatePipes(dt);
      }
      gameState = state.GameState.playing;
    }
    gameObjects.removeWhere((obj) => obj.markedToDelete);
    for (final obj in ui) {
      obj.update(dt);
    }
    if (gameState != state.GameState.gameOver) {
      for (final obj in gameObjects) {
        obj.update(dt);
        if (obj is Dash) {
          final collisions = BoxCollider.getCollision(obj, gameObjects);
          for (final other in collisions) {
            if (other is p.Pipe || other is Floor) {
              gameOver();
              break;
            }
          }
        }
      }
    }
    setState(() {
      //
    });
    //getFPS();
  }

  @override
  void initState() {
    pipeGenerator = PipeGenerator(isAlive: true, obj: gameObjects);
    points = Points(const Size(100, 100), const Offset(200, 70));
    gameObjects.add(points);
    loadSprite('assets/sprites/basic_pipe.png').then(
      (sprite) => {pipeGenerator!.setUpperSprite(sprite)},
    );
    loadSprite('assets/sprites/lower_pipe.png').then(
      (sprite) => {pipeGenerator!.setLowerSprite(sprite)},
    );
    loadSprite('assets/sprites/base.png').then(
      (sprite) => {
        gameObjects.addAll([
          Floor(
            sprite,
            const Offset(0, 750),
            const Size(301, 120),
          ),
          Floor(
            sprite,
            const Offset(301, 750),
            const Size(301, 120),
          ),
          Floor(
            sprite,
            const Offset(602, 750),
            const Size(301, 120),
          ),
        ]),
      },
    );
    loadSprite('assets/sprites/dash/birdie.png').then(
      (sprite) => {
        dash = Dash(
          sprite,
          const Offset(50, 400),
          const Size(56.8, 40),
        ),
        gameObjects.add(dash),
      },
    );
    ticker = createTicker(_onTick)..start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (!isScreenTouched) {
            isScreenTouched = true;
            dash.isReadyToPlay = true;
          } else {
            dash.flap();
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/basic_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomPaint(
            painter: GamePainter(
              gameObjects: gameObjects,
              ui: ui,
            ),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}
