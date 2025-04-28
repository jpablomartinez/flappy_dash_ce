import 'dart:ui';
import 'package:flutter/material.dart' as material;
import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/utils/text.dart';

class Logo extends GameObject {
  @override
  void awake() {}

  @override
  void render(Canvas canvas) {
    final center = size.center(Offset.zero);
    Paragraph paragraph1 = renderText(
      'This is a flappy bird clone game. Is a open source code project, just for learning and fun.',
      18,
      material.Colors.black87,
      height: 1.3,
    );
    paragraph1.layout(ParagraphConstraints(width: size.width - 40));

    final double xCenterParagraphText = paragraph1.width / 2;
    canvas.drawParagraph(paragraph1, Offset(center.dx - xCenterParagraphText, center.dy - 100));

    Paragraph paragraph2 = renderText('JK Studios', 26, material.Colors.orange.shade900);
    final double xCenterParagraphLogo = (paragraph2.maxIntrinsicWidth) / 2;
    canvas.drawParagraph(paragraph2, Offset(center.dx - xCenterParagraphLogo, center.dy + 100));
  }

  @override
  void update(double deltaTime) {}
}
