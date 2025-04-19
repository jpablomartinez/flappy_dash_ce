import 'dart:ui';
import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/utils/constants.dart';
import 'package:flutter/material.dart' as material;

class Button extends GameObject {
  final Size parentSize;
  final String label;
  final VoidCallback onTap;
  final Rect rect;

  Button({
    required this.parentSize,
    required this.label,
    required this.onTap,
    required this.rect,
  });

  @override
  bool shouldRender(GameState state) => state == GameState.gameOver;

  @override
  void render(Canvas canvas) {
    final double left = (430 - 150) / 2; //leftCenter(430, 150);
    Rect outerRect = Rect.fromLTWH(left, parentSize.height + initialTop + 50 + 50, 154, 58);
    Rect middleRect = Rect.fromLTWH(left + 2, parentSize.height + initialTop + 50 + 52, 150, 50);
    //Rect innerRect = Rect.fromLTWH(left + 5, scoreBoardSize.height + initialTop + 55, 144, 42);

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
      rect,
      Paint()
        ..style = PaintingStyle.fill
        ..color = material.Colors.orange.shade400,
    );
    Paragraph paragraph = renderText(label, 26, material.Colors.white);

    final double x = rect.left + (rect.width - paragraph.maxIntrinsicWidth) / 2;
    final double y = rect.top + (rect.height - paragraph.height) / 2;

    canvas.drawParagraph(paragraph, Offset(x, y));
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
    return rect.contains(position);
  }

  @override
  void update(double deltaTime) {}
}
