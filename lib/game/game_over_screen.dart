import 'dart:ui';
import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/core/size.dart';
import 'package:flappy_dash_ce/utils/text.dart';
import 'package:flutter/material.dart' as material;
import 'package:flappy_dash_ce/core/game_object.dart';
import 'dart:math';

class GameOverScreen extends GameObject {
  double flash = 0;
  double scoreBoardTime = 0;
  int score = 0;
  int bestScore = 0;
  Size scoreBoardSize = const Size(150, 200);
  double initialTop = 140;
  double top = 205;

  double leftCenter(double screenWidth, double elementWidth) => (screenWidth - elementWidth) / 2;

  GameOverScreen(Size s, Offset pos) {
    size = s;
    position = pos;
  }

  @override
  void awake() {
    flash = 0;
    scoreBoardTime = 0;
    initialTop = 140;
  }

  @override
  bool shouldRender(GameState state) => state == GameState.gameOver;

  @override
  bool shouldUpdate(GameState state) => state == GameState.gameOver;

  void renderScoreboard(Canvas canvas) {
    final double left = leftCenter(SizeManager.instance.screen.width, 150);

    canvas.drawRect(
      Rect.fromLTWH(left, initialTop, scoreBoardSize.width, scoreBoardSize.height),
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 226, 218, 127),
    );
    Paragraph paragraph1 = renderText('Score', 20, material.Colors.orange.shade900);
    Paragraph paragraph2 = renderText('$score', 34, material.Colors.white);
    Paragraph paragraph3 = renderText('Best', 20, material.Colors.orange.shade900);
    Paragraph paragraph4 = renderText('$bestScore', 34, material.Colors.white);

    const double bottomMargin = 10;

    final double xCenterParagraphText = left + (scoreBoardSize.width - paragraph1.maxIntrinsicWidth) / 2;
    final double xCenterParagraphScore = left + (scoreBoardSize.width - paragraph2.maxIntrinsicWidth) / 2;

    final double xCenterParagraphBest = left + (scoreBoardSize.width - paragraph3.maxIntrinsicWidth) / 2;
    final double xCenterParagraphBestScore = left + (scoreBoardSize.width - paragraph4.maxIntrinsicWidth) / 2;

    final double paragraph1HeightWithMargin = initialTop + 25 + paragraph1.height + bottomMargin;
    final double paragraph2HeightWithMargin = paragraph1HeightWithMargin + paragraph2.height + bottomMargin + 10;
    final double paragraph3HeightWithMargin = paragraph2HeightWithMargin + paragraph3.height + bottomMargin;

    canvas.drawParagraph(paragraph1, Offset(xCenterParagraphText, initialTop + 25));
    canvas.drawParagraph(paragraph2, Offset(xCenterParagraphScore, paragraph1HeightWithMargin));
    canvas.drawParagraph(paragraph3, Offset(xCenterParagraphBest, paragraph2HeightWithMargin));
    canvas.drawParagraph(paragraph4, Offset(xCenterParagraphBestScore, paragraph3HeightWithMargin));
  }

  void renderButton(Canvas canvas, String text) {
    final double left = leftCenter(SizeManager.instance.screen.width, 150);
    Rect outerRect = Rect.fromLTWH(left, scoreBoardSize.height + initialTop + 50, 154, 58);
    Rect middleRect = Rect.fromLTWH(left + 2, scoreBoardSize.height + initialTop + 52, 150, 50);
    Rect innerRect = Rect.fromLTWH(left + 5, scoreBoardSize.height + initialTop + 55, 144, 42);

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
    Paragraph paragraph = renderText(text, 26, material.Colors.white);

    final double x = innerRect.left + (innerRect.width - paragraph.maxIntrinsicWidth) / 2;
    final double y = innerRect.top + (innerRect.height - paragraph.height) / 2;

    canvas.drawParagraph(paragraph, Offset(x, y));
  }

  @override
  void render(Canvas canvas) {
    if (flash < 0.180) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, SizeManager.instance.screen.width, SizeManager.instance.screen.height),
        Paint()
          ..style = PaintingStyle.fill
          ..color = material.Colors.black.withOpacity(0.9),
      );
    } else {
      renderScoreboard(canvas);
      //renderButton(canvas, 'Restart');
    }
  }

  @override
  void update(double deltaTime) {
    if (flash <= 0.180) {
      flash += deltaTime;
    } else {
      if (scoreBoardTime < 0.2) {
        scoreBoardTime += deltaTime;
        // percentage of the way through the animation (0 to 1)
        double t = scoreBoardTime / 0.5;

        // Apply easing using sin curve
        double eased = 0.5 - 0.5 * cos(t * pi);
        initialTop = initialTop + (40 * eased);
      }
    }
  }
}
