import 'dart:ui';

abstract class UI {
  double leftCenter(double screenWidth, double elementWidth) => (screenWidth - elementWidth) / 2;
  Paragraph renderText(String text, double fontSize, Color color);
  void render(Canvas canvas);
}
