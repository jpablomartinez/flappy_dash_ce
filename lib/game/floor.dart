import 'dart:ui';

import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/core/sprite.dart';

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
  bool shouldUpdate(GameState state) => state != GameState.gameOver;

  @override
  void render(Canvas canvas) {
    sprite.render(canvas, position, size);
  }

  @override
  void update(double deltaTime) {
    position = position.translate(-200 * deltaTime, 0);
    if (position.dx < -301) {
      position = position.translate(903, 0);
    }
  }
}
