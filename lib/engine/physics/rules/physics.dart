import 'dart:ui';
import 'package:flappy_dash_ce/configuration/game_config.dart';
import 'package:flappy_dash_ce/engine/core/game_object.dart';
import 'package:flappy_dash_ce/engine/utils/size.dart';

class Physics {
  final GameConfig gameConfig = GameConfig();
  final GameObject obj;
  final double gravity;
  final double impulse;
  final double maxFallSpeed;
  final double yOffsetLowerLimit;
  final double yOffsetUpperLimit;

  bool isJumping = false;
  double jumpTime = 0;
  double velocityY = 0;
  double maxJumpTime;
  double angle = 0;
  double tiltDelayTimer = 0;
  double fallingTime = 0;

  Physics({
    required this.obj,
    required this.yOffsetLowerLimit,
    this.yOffsetUpperLimit = -10,
    this.gravity = 800,
    this.impulse = -270,
    this.maxFallSpeed = 600,
    this.maxJumpTime = 0.2,
  });

  void reset() {
    angle = 0;
  }

  void jump() {
    if (!isJumping) {
      velocityY = impulse;
      isJumping = true;
      jumpTime = 0;
      tiltDelayTimer = 0;
    }
  }

  void update(double dt) {
    if (obj.position.dy <= yOffsetLowerLimit) {
      if (isJumping) {
        jumpTime += dt;
        if (jumpTime > maxJumpTime) {
          isJumping = false;
          jumpTime = 0;
        }
      }
      velocityY += gravity * dt;
      velocityY = velocityY.clamp(-double.infinity, maxFallSpeed);
      obj.position = obj.position.translate(0, velocityY * dt);
      getAngle(dt);
    }
  }

  void getAngle(double dt) {
    double maxTiltUp = gameConfig.maxTiltUp;
    double maxTiltDown = gameConfig.maxTiltDown;
    double tiltLerpSpeed = gameConfig.tiltLerpSpeed;
    double targetAngle;

    if (isJumping) {
      targetAngle = maxTiltUp;
      fallingTime = 0;
    } else {
      fallingTime += dt;
      if (fallingTime < gameConfig.fallingTime) {
        targetAngle = maxTiltUp;
      } else {
        if (fallingTime >= gameConfig.maxFallingTime || obj.position.dy >= SizeManager.instance.screen.height - SizeManager.instance.getFloorHeight() - 30) {
          targetAngle = maxTiltDown;
        } else {
          targetAngle = (velocityY / maxFallSpeed) * maxTiltDown;
          targetAngle = targetAngle.clamp(maxTiltUp, maxTiltDown);
        }
      }
    }

    angle = lerpDouble(angle, targetAngle, tiltLerpSpeed * dt)!;
  }
}
