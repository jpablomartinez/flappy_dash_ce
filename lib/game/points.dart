import 'dart:ui';
//import 'package:flutter/material.dart' as material;
import 'package:flappy_dash_ce/core/game_object.dart';

class Points extends GameObject {
  int record = 0;

  Points(Size s, Offset pos) {
    size = s;
    position = pos;
  }

  void addPoint(int v) {
    record += v;
  }

  @override
  void render(Canvas canvas) {
    ParagraphStyle style = ParagraphStyle(fontSize: 50, fontFamily: 'FlappyBirdy');
    /*TextStyle textStyle = TextStyle(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = material.Colors.white,
    );*/
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(style);
    //paragraphBuilder.pushStyle(textStyle);
    paragraphBuilder.addText('$record');
    Paragraph p = paragraphBuilder.build()..layout(const ParagraphConstraints(width: double.infinity));
    canvas.drawParagraph(p, position);
  }

  @override
  void update(double deltaTime) {}
}
