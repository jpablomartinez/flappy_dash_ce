import 'package:flappy_dash_ce/engine/physics/colliders/collider.dart';
import 'package:flappy_dash_ce/engine/core/game_state.dart';
import 'package:flutter/material.dart';

abstract class GameObject with Collider {
  bool markedToDelete = false;
  Offset position = const Offset(0, 0);
  Size size = const Size(0, 0);
  void update(double deltaTime);
  void render(Canvas canvas);
  void awake();
  VoidCallback callback = () {};
  bool shouldUpdate(GameState state) => true;
  bool shouldRender(GameState state) => true;
  bool checkTap(Offset tapPositon, Rect rect) => rect.contains(tapPositon);
  void renderHitbox(Canvas canvas, {double angle = 0}) {
    final dst = Rect.fromLTWH(
      position.dx,
      position.dy,
      size.width,
      size.height,
    );
    canvas.save();
    canvas.translate(dst.center.dx, dst.center.dy);
    canvas.rotate(angle);
    canvas.translate(-dst.center.dx, -dst.center.dy);
    canvas.drawRect(
      collider,
      Paint()
        ..color = const Color(0xFF000000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );
    canvas.restore();
  }

  @override
  Rect get collider => position & size;
}
