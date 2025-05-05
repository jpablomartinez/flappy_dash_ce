import 'dart:ui';

class SpriteAnimation {
  final Image spriteSheet;
  final int frameCount;
  final double frameWidth;
  final double frameHeight;
  final double frameDuration;

  double _elapsedTime = 0;
  double _currentFrame = 0;

  SpriteAnimation({
    required this.spriteSheet,
    required this.frameCount,
    required this.frameWidth,
    required this.frameHeight,
    required this.frameDuration,
  });

  void update(double dt) {
    _elapsedTime += dt;
    if (_elapsedTime >= frameDuration) {
      _elapsedTime = 0;
      _currentFrame = (_currentFrame + 1) % frameCount;
    }
  }

  void render(Canvas canvas, Offset position, Size size, double angle) {
    final src = Rect.fromLTWH(
      _currentFrame * frameWidth,
      0,
      frameWidth,
      frameHeight,
    );
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
    canvas.drawImageRect(spriteSheet, src, dst, Paint());
    canvas.restore();
  }
}
