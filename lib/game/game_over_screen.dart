import 'dart:ui';
import 'package:flutter/material.dart' as material;
import 'package:flappy_dash_ce/core/game_object.dart';

class GameOverScreen extends GameObject {
  double flash = 0;

  GameOverScreen(Size s, Offset pos) {
    size = s;
    position = pos;
  }

  @override
  void render(Canvas canvas) {
    if (flash < 0.1) {
      canvas.drawRect(
        const Rect.fromLTWH(0, 0, 430, 920),
        Paint()
          ..style = PaintingStyle.fill
          ..color = material.Colors.black.withOpacity(0.9),
      );
    }
  }

  @override
  void update(double deltaTime) {
    flash += deltaTime;
  }
}
