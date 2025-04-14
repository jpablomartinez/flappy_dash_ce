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
  double angle = 0;
  double tiltDelayTimer = 0;

  Physics({
    required this.position,
    this.gravity = 650,
    this.impulse = -250,
    this.maxFallSpeed = 680,
    this.maxJumpTime = 0.2,
  });

  void jump() {
    if (!isJumping) {
      velocityY = impulse;
      isJumping = true;
      jumpTime = 0;
      tiltDelayTimer = 0;
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
    velocityY = velocityY.clamp(-double.infinity, maxFallSpeed);
    position = position.translate(0, velocityY * dt);
    getAngle(dt);
  }

  void getAngle(double dt) {
    double maxTiltUp = -0.8;
    double maxTiltDown = 1.3;
    double tiltLerpSpeed = 4.0; // how fast it smooths between angles
    double targetAngle;
    if (isJumping) {
      targetAngle = maxTiltUp;
      tiltDelayTimer = 0;
    } else {
      if (tiltDelayTimer < 0.8) {
        tiltDelayTimer += dt; // Increment the delay timer
        targetAngle = maxTiltUp; // Keep the bird tilted upwards for now
      } else {
        targetAngle = (velocityY / maxFallSpeed) * maxTiltDown;
        targetAngle = targetAngle.clamp(maxTiltUp, maxTiltDown);
      }
    }

    // Smooth transition
    angle = lerpDouble(angle, targetAngle, tiltLerpSpeed * dt)!;
  }
}
