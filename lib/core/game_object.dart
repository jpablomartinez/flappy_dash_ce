import 'package:flappy_dash_ce/core/collider.dart';
import 'package:flutter/material.dart';

abstract class GameObject with Collider {
  bool markedToDelete = false;
  Offset position = const Offset(0, 0);
  Size size = const Size(0, 0);
  void update(double deltaTime);
  void render(Canvas canvas);
  void renderHitbox(Canvas canvas) {
    canvas.drawRect(
      collider,
      Paint()
        ..color = const Color(0xFF000000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );
  }

  @override
  Rect get collider => position & size;
}
