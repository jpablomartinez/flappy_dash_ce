import 'dart:ui';

import 'package:flappy_dash_ce/engine/core/game_object.dart';
import 'package:flutter/material.dart' as material;

class Loader extends GameObject {
  double increaseFactor = 0.0;
  double animationTime = 0.0;
  late double progress;
  double lastProgress = 0;

  @override
  void awake() {}

  void setProgress(double p) {
    progress = p;
  }

  @override
  void render(Canvas canvas) {
    const barWidth = 300.0;
    const barHeight = 30.0;

    final center = size.center(Offset.zero);
    //print(center.toString());
    final barRect = Rect.fromCenter(
      center: center,
      width: barWidth,
      height: barHeight,
    );

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = material.Colors.brown.shade700;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = material.Colors.orange.shade400;

    canvas.drawRect(barRect, borderPaint);

    final filledRect = Rect.fromLTWH(
      barRect.left,
      barRect.top + 2,
      3 * increaseFactor,
      barHeight - 4,
    );

    canvas.drawRect(filledRect, fillPaint);
  }

  @override
  void update(double deltaTime) {
    animationTime += deltaTime;
    const smoothingSpeed = 4.0; // tweak this for snappier/slower interpolation
    increaseFactor = lerpDouble(increaseFactor, progress, deltaTime * smoothingSpeed)!;
  }
}
