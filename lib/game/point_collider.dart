import 'dart:ui';

import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';

class PointCollider extends GameObject {
  bool touched = false;

  PointCollider(Offset pos, Size s) {
    position = pos;
    size = s;
  }

  @override
  bool shouldUpdate(GameState state) => state == GameState.playing;

  @override
  bool shouldRender(GameState state) => state == GameState.playing;

  @override
  Rect get collider => Rect.fromLTWH(
        position.dx + 3,
        position.dy + 4,
        size.width - 2 * 4,
        size.height - 2 * 4,
      );

  @override
  void render(Canvas canvas) {
    //renderHitbox(canvas);
  }

  @override
  void update(double deltaTime) {
    position = position.translate(-200 * deltaTime, 0);
    if (position.dx < -200) {
      markedToDelete = true;
    }
  }

  @override
  void awake() {}
}
