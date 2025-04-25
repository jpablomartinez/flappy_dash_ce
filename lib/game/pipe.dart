import 'dart:ui';
import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/core/sprite.dart';

class Pipe extends GameObject {
  late Image image;
  late Sprite sprite;

  Pipe(Image i, Offset pos, Size s) {
    size = s;
    position = pos;
    image = i;
    sprite = Sprite(sprite: image, size: s, position: pos);
  }

  @override
  Rect get collider => Rect.fromLTWH(
        position.dx + 3,
        position.dy + 4,
        size.width - 2 * 4,
        size.height - 2 * 4,
      );

  @override
  bool shouldUpdate(GameState state) => state == GameState.playing;

  @override
  void update(double deltaTime) {
    position = position.translate(-200 * deltaTime, 0);
    if (position.dx < -200) {
      markedToDelete = true;
    }
  }

  @override
  void render(Canvas canvas) {
    sprite.render(canvas, position, size);
  }

  @override
  void awake() {}
}
