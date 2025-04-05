import 'dart:ui';

import 'package:flappy_dash_ce/core/game_object.dart';

class Dash extends GameObject {
  final Image sprite;
  final Offset position;
  final Size size;

  Dash({
    required this.sprite,
    required this.position,
    required this.size,
  });

  @override
  void update(double deltaTime) {}

  @override
  void render(Canvas canvas) {
    final dst = Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
    final src = Rect.fromLTWH(0, 0, sprite.width.toDouble(), sprite.height.toDouble());
    canvas.drawImageRect(sprite, src, dst, Paint());
  }
}
