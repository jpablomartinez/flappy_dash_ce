import 'dart:ui';

import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/physics.dart';
import 'package:flappy_dash_ce/core/sprite_animation.dart';

class Dash extends GameObject {
  final Image spriteSheet;
  final Size size;
  late SpriteAnimation spriteAnimation;
  late Physics physics;
  bool isReadyToPlay = false;

  Dash({
    required this.spriteSheet,
    required this.size,
    required this.physics,
  }) {
    start();
  }

  void start() {
    spriteAnimation = SpriteAnimation(
      spriteSheet: spriteSheet,
      frameCount: 3,
      frameWidth: 34,
      frameHeight: 24,
      frameDuration: 0.1,
    );
  }

  void flap() {
    physics.jump();
  }

  @override
  void update(double deltaTime) {
    if (isReadyToPlay) {
      physics.update(deltaTime);
    }
    spriteAnimation.update(deltaTime);
  }

  @override
  void render(Canvas canvas) {
    spriteAnimation.render(canvas, physics.position, size, physics.angle);
  }
}
