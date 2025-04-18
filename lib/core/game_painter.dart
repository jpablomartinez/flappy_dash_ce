import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flutter/rendering.dart';

class GamePainter extends CustomPainter {
  final List<GameObject> gameObjects;
  final List<GameObject> ui;
  const GamePainter({required this.gameObjects, required this.ui});

  @override
  void paint(Canvas canvas, Size size) {
    for (final gameObject in gameObjects) {
      gameObject.render(canvas);
    }
    for (final gameObject in ui) {
      gameObject.render(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
