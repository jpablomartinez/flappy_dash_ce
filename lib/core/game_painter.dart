import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flutter/rendering.dart';

class GamePainter extends CustomPainter {
  final List<GameObject> gameObjects;

  const GamePainter({required this.gameObjects});

  @override
  void paint(Canvas canvas, Size size) {
    for (final gameObject in gameObjects) {
      gameObject.render(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
