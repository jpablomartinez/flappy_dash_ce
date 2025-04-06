import 'dart:ui';

class Physics {
  Offset position;
  final double gravity;
  final double impulse;
  final double maxFallSpeed;

  bool isJumping = false;
  double jumpTime = 0;
  double velocityY = 0;
  double maxJumpTime;

  Physics({
    required this.position,
    this.gravity = 420,
    this.impulse = -260,
    this.maxFallSpeed = 600,
    this.maxJumpTime = 0.4,
  });

  void jump() {
    if (!isJumping) {
      velocityY = impulse;
      isJumping = true;
      jumpTime = 0;
    }
  }

  void update(double dt) {
    if (isJumping) {
      jumpTime += dt;
      if (jumpTime > maxJumpTime) {
        isJumping = false;
        jumpTime = 0;
      }
    }
    velocityY += gravity * dt;
    if (velocityY > maxFallSpeed) {
      velocityY = maxFallSpeed;
    }
    position = position.translate(0, velocityY * dt);
  }
}
