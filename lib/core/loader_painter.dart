import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flutter/material.dart';

class LoaderPainter extends CustomPainter {
  final List<GameObject> ui;
  final GameState gameState;
  final Size size;

  LoaderPainter({
    required this.ui,
    required this.gameState,
    required this.size,
  }) {
    for (final obj in ui) {
      obj.size = size;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final obj in ui) {
      if (obj.shouldRender(gameState) || obj.shouldUpdate(gameState)) {
        obj.render(canvas);
      }
    }
  }

  @override
  bool shouldRepaint(covariant LoaderPainter oldDelegate) => true;
}
