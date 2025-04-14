import 'dart:ui';

import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/sprite.dart';

class Floor extends GameObject {
  final Image image;
  final Size size;
  Offset position;

  late Sprite sprite;

  Floor({
    required this.image,
    required this.size,
    required this.position,
  }) {
    sprite = Sprite(
      sprite: image,
      size: size,
      position: position,
    );
  }

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
