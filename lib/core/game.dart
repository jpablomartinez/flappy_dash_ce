import 'package:flappy_dash_ce/core/game_state.dart';

abstract class Game {
  Future<void> loadAssets();
  void getFPS();
  void onTick(Duration elapsedTime);
  void init();
  void start();
  void play();
  void restart();
  void gameover();
  void setGameState(GameState state);
  void removeObjects();
  void renderGameObjects(double deltaTime);
  void renderUI(double deltaTime);
}
