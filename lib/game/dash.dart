import 'dart:ui';
import 'package:flappy_dash_ce/engine/core/game_object.dart';
import 'package:flappy_dash_ce/engine/core/game_state.dart';
import 'package:flappy_dash_ce/engine/physics/rules/physics.dart';
import 'package:flappy_dash_ce/engine/utils/size.dart';
import 'package:flappy_dash_ce/engine/sprite/sprite_animation.dart';

class Dash extends GameObject {
  late Image spriteSheet;
  late SpriteAnimation spriteAnimation;
  late Physics physics;
  late GameState gameState;
  late Offset initial;
  bool isReadyToPlay = false;

  Dash(Image sprite, Offset pos, Size s, GameState state) {
    position = pos;
    initial = pos;
    physics = Physics(obj: this, yOffsetLowerLimit: SizeManager.instance.getFloorYPosition() - 50);
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

  @override
  void awake() {
    position = initial;
    gameState = GameState.start;
    isReadyToPlay = false;
    physics.reset();
  }

  @override
  Rect get collider => Rect.fromLTWH(
        position.dx + 15,
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
