import 'dart:ui';
import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/core/size.dart';
import 'package:flappy_dash_ce/utils/constants.dart';
import 'package:flutter/material.dart' as material;
import 'dart:math';

class Button extends GameObject {
  final Size parentSize;
  final String label;
  final VoidCallback onTap;
  final Rect rect;

  double animationTime = 0;
  double top = initialTop;
  late Rect innerRect;

  Button({
    required this.parentSize,
    required this.label,
    required this.onTap,
    required this.rect,
  }) {
    innerRect = Rect.fromLTWH(rect.left, rect.top + top, rect.width, rect.height);
  }

  @override
  void awake() {
    animationTime = 0;
    top = initialTop;
    innerRect = Rect.fromLTWH(rect.left, rect.top + top, rect.width, rect.height);
  }

  @override
  bool shouldRender(GameState state) => state == GameState.gameOver;

  @override
  bool shouldUpdate(GameState state) => state == GameState.gameOver;

  @override
  void render(Canvas canvas) {
    if (animationTime > 0.18) {
      final double left = (SizeManager.instance.screen.width - 150) / 2; //leftCenter(430, 150);
      Rect outerRect = Rect.fromLTWH(left, parentSize.height + top + 50, 154, 58);
      Rect middleRect = Rect.fromLTWH(left + 2, parentSize.height + top + 52, 150, 50);
      innerRect = Rect.fromLTWH(rect.left, parentSize.height + top + 56, rect.width, rect.height);
      canvas.drawRect(
        outerRect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = material.Colors.brown.shade700,
      );
      canvas.drawRect(
        middleRect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = material.Colors.white,
      );
      canvas.drawRect(
        innerRect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = material.Colors.orange.shade400,
      );
      Paragraph paragraph = renderText(label, 26, material.Colors.white);

      final double x = innerRect.left + (innerRect.width - paragraph.maxIntrinsicWidth) / 2;
      final double y = innerRect.top + (innerRect.height - paragraph.height) / 2;

      canvas.drawParagraph(paragraph, Offset(x, y));
    }
  }

  //@override
  Paragraph renderText(String text, double fontSize, Color color) {
    ParagraphStyle style = ParagraphStyle(fontSize: fontSize, fontFamily: 'FlappyBirdy');
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(style);
    TextStyle textStyle = TextStyle(color: color);
    paragraphBuilder.pushStyle(textStyle);
    paragraphBuilder.addText(text);
    return paragraphBuilder.build()..layout(const ParagraphConstraints(width: double.infinity));
  }

  bool checkOnTap(Offset position) {
    return innerRect.contains(position);
  }

  @override
  void update(double deltaTime) {
    animationTime += deltaTime;
    if (animationTime < 0.18) {
    } else if (animationTime < 0.38) {
      // percentage of the way through the animation (0 to 1)
      double t = animationTime / 0.5;
      // Apply easing using sin curve
      double eased = 0.5 - 0.5 * cos(t * pi);
      top += (10 * eased);
    }
  }
}
