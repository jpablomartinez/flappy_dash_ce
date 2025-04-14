import 'dart:ui';

class Sprite {
  final Image sprite;
  final Size size;
  final Offset position;

  Sprite({
    required this.sprite,
    required this.size,
    required this.position,
  });

  void render(Canvas canvas, Offset position, Size size) {
    final dst = Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
    final src = Rect.fromLTWH(0, 0, sprite.width.toDouble(), sprite.height.toDouble());
    canvas.drawImageRect(sprite, src, dst, Paint());
  }
}
