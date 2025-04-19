import 'dart:ui';
import 'package:flutter/material.dart' as material;
import 'package:flappy_dash_ce/core/game_object.dart';

class GameOverScreen extends GameObject {
  double flash = 0;

  GameOverScreen(Size s, Offset pos) {
    size = s;
    position = pos;
  }

  void renderScoreboard(Canvas canvas, String text) {
    canvas.drawRect(
      const Rect.fromLTWH(125, 205, 150, 200),
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 226, 218, 127),
    );
    Paragraph paragraph1 = renderText(text, 20, material.Colors.orange.shade900);
    Paragraph paragraph2 = renderText('0', 32, material.Colors.white);
    Paragraph paragraph3 = renderText('Best', 20, material.Colors.orange.shade900);
    Paragraph paragraph4 = renderText('0', 32, material.Colors.white);

    //final double x = innerRect.left + (innerRect.width - paragraph.maxIntrinsicWidth) / 2;
    //final double y = innerRect.top + (innerRect.height - paragraph.height) / 2;

    canvas.drawParagraph(paragraph1, Offset(180, 220));
    canvas.drawParagraph(paragraph2, Offset(180, 240));
    canvas.drawParagraph(paragraph3, Offset(180, 280));
    canvas.drawParagraph(paragraph4, Offset(180, 320));
  }

  void renderButton(Canvas canvas, String text) {
    const outerRect = Rect.fromLTWH(158, 298, 154, 58);
    const middleRect = Rect.fromLTWH(160, 300, 150, 50);
    const innerRect = Rect.fromLTWH(165, 305, 140, 40);

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
      const Rect.fromLTWH(165, 305, 140, 40),
      Paint()
        ..style = PaintingStyle.fill
        ..color = material.Colors.orange.shade400,
    );
    Paragraph paragraph = renderText(text, 26, material.Colors.white);

    final double x = innerRect.left + (innerRect.width - paragraph.maxIntrinsicWidth) / 2;
    final double y = innerRect.top + (innerRect.height - paragraph.height) / 2;

    canvas.drawParagraph(paragraph, Offset(x, y));
  }

  Paragraph renderText(String text, double fontSize, Color color) {
    ParagraphStyle style = ParagraphStyle(fontSize: fontSize, fontFamily: 'FlappyBirdy');
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(style);
    TextStyle textStyle = TextStyle(color: color);
    paragraphBuilder.pushStyle(textStyle);
    paragraphBuilder.addText(text);
    return paragraphBuilder.build()..layout(const ParagraphConstraints(width: double.infinity));
    //canvas.drawParagraph(p, position);
  }

  @override
  void render(Canvas canvas) {
    if (flash < 0.180) {
      canvas.drawRect(
        const Rect.fromLTWH(0, 0, 430, 920),
        Paint()
          ..style = PaintingStyle.fill
          ..color = material.Colors.black.withOpacity(0.9),
      );
    } else {
      //renderButton(canvas, 'Restart');
      //renderScoreboard(canvas, 'Score');
    }
  }

  @override
  void update(double deltaTime) {
    if (flash <= 0.180) {
      flash += deltaTime;
    }
  }
}
