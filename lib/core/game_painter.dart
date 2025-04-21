import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flutter/rendering.dart';

class GamePainter extends CustomPainter {
  final List<GameObject> gameObjects;
  final List<GameObject> ui;
  final GameState gameState;
  const GamePainter({
    required this.gameObjects,
    required this.ui,
    required this.gameState,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final gameObject in gameObjects) {
      gameObject.render(canvas);
    }
    for (final gameObject in ui) {
      if (gameObject.shouldRender(gameState) || gameObject.shouldUpdate(gameState)) {
        gameObject.render(canvas);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
