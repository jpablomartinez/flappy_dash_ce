import 'dart:ui';

class SpriteAnimation {
  final Image spriteSheet;
  final int frameCount;
  final double framewWidth;
  final double frameHeight;
  final double frameDuration;

  double _elapsedTime = 0;
  double _currentFrame = 0;

  SpriteAnimation({
    required this.spriteSheet,
    required this.frameCount,
    required this.framewWidth,
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

  void render(Canvas canvas, Offset position, Size size) {
    final src = Rect.fromLTWH(
      _currentFrame * framewWidth,
      0,
      framewWidth,
      frameHeight,
    );
    final dst = Rect.fromLTWH(
      position.dx,
      position.dy,
      size.width,
      size.height,
    );
    canvas.drawImageRect(spriteSheet, src, dst, Paint());
  }
}
