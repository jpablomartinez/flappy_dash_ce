import 'dart:ui';
import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/core/physics.dart';
import 'package:flappy_dash_ce/core/sprite_animation.dart';

class Dash extends GameObject {
  late Image spriteSheet;
  late SpriteAnimation spriteAnimation;
  late Physics physics;
  late GameState gameState;
  bool isReadyToPlay = false;

  Dash(Image sprite, Offset pos, Size s, GameState state) {
    position = pos;
    physics = Physics(obj: this);
    size = s;
    spriteSheet = sprite;
    gameState = state;
    start();
  }

  void setPosition(Offset pos) {
    position = pos;
  }

  void setGameState(GameState state) {
    gameState = state;
  }

  void start() {
    spriteAnimation = SpriteAnimation(
      spriteSheet: spriteSheet,
      frameCount: 3,
      frameWidth: 34,
      frameHeight: 24,
      frameDuration: 0.06,
    );
  }

  void flap() {
    physics.jump();
  }

  void awake() {
    physics.angle = 0;
  }

  @override
  Rect get collider => Rect.fromLTWH(
        position.dx + 7,
        position.dy + 4,
        size.width - 4 * 4,
        size.height - 2 * 4,
      );

  @override
  void update(double deltaTime) {
    if (isReadyToPlay) {
      physics.update(deltaTime);
    }
    if (gameState != GameState.gameOver) {
      spriteAnimation.update(deltaTime);
    }
  }

  @override
  void render(Canvas canvas) {
    spriteAnimation.render(canvas, position, size, physics.angle);
  }
}
