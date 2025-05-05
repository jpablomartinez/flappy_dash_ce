import 'dart:ui';

import 'package:flappy_dash_ce/engine/core/game_object.dart';
import 'package:flappy_dash_ce/engine/core/game_state.dart';
import 'package:flappy_dash_ce/engine/utils/size.dart';
import 'package:flappy_dash_ce/engine/sprite/sprite.dart';

class Floor extends GameObject {
  late Image image;
  late Sprite sprite;

  Floor(
    img,
    pos,
    s,
  ) {
    image = img;
    position = pos;
    size = s;
    sprite = Sprite(
      sprite: image,
      size: size,
      position: position,
    );
  }

  @override
  Rect get collider => Rect.fromLTWH(
        position.dx + 3,
        position.dy,
        size.width - 3,
        size.height,
      );

  @override
  bool shouldUpdate(GameState state) => state != GameState.gameOver;

  @override
  void render(Canvas canvas) {
    sprite.render(canvas, position, size);
  }

  @override
  void update(double deltaTime) {
    position = position.translate(-200 * deltaTime, 0);
    if (position.dx < -SizeManager.instance.getFloorXPosition()) {
      position = position.translate(SizeManager.instance.getFloorXPosition() * 3, 0);
    }
  }

  @override
  void awake() {}
}
