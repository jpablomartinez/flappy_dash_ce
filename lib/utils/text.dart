import 'dart:ui';

Paragraph renderText(
  String text,
  double fontSize,
  Color color, {
  double height = 1,
}) {
  ParagraphStyle style = ParagraphStyle(
    fontSize: fontSize,
    fontFamily: 'FlappyBirdy',
    height: height,
  );
  ParagraphBuilder paragraphBuilder = ParagraphBuilder(style);
  TextStyle textStyle = TextStyle(color: color);
  paragraphBuilder.pushStyle(textStyle);
  paragraphBuilder.addText(text);
  return paragraphBuilder.build()..layout(const ParagraphConstraints(width: double.infinity));
}
