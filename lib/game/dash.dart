import 'dart:ui';

import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/physics.dart';
import 'package:flappy_dash_ce/core/sprite_animation.dart';

class Dash extends GameObject {
  final Image spriteSheet;
  final Size size;
  late SpriteAnimation spriteAnimation;
  late Physics physics;

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
      frameCount: 12,
      framewWidth: 64,
      frameHeight: 64,
      frameDuration: 0.1,
    );
  }

  void flap() {
    physics.jump();
  }

  @override
  void update(double deltaTime) {
    physics.update(deltaTime);
    spriteAnimation.update(deltaTime);
  }

  @override
  void render(Canvas canvas) {
    //final dst = Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
    //final src = Rect.fromLTWH(0, 0, sprites[actualSprite].width.toDouble(), sprites[actualSprite].height.toDouble());
    //canvas.drawImageRect(sprites[actualSprite], src, dst, Paint());
    spriteAnimation.render(canvas, physics.position, size);
  }
}
