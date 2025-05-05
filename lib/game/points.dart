import 'dart:ui';
import 'package:flappy_dash_ce/engine/core/game_object.dart';
import 'package:flappy_dash_ce/engine/core/game_state.dart';

class Points extends GameObject {
  int record = 0;
  int bestScore = 0;
  late GameState state;

  Points(Size s, Offset pos) {
    size = s;
    position = pos;
  }

  void setGameState(GameState s) {
    state = s;
  }

  void addPoint(int v) {
    record += v;
  }

  void setBestScore(int v) {
    bestScore = v;
  }

  @override
  bool shouldUpdate(GameState state) => state != GameState.gameOver;

  @override
  bool shouldRender(GameState state) => state != GameState.gameOver;

  @override
  void render(Canvas canvas) {
    if (shouldRender(state)) {
      ParagraphStyle style = ParagraphStyle(fontSize: 50, fontFamily: 'FlappyBirdy');
      ParagraphBuilder paragraphBuilder = ParagraphBuilder(style);
      paragraphBuilder.addText('$record');
      Paragraph p = paragraphBuilder.build()..layout(const ParagraphConstraints(width: double.infinity));
      canvas.drawParagraph(p, position);
    }
  }

  @override
  void update(double deltaTime) {}

  @override
  void awake() {
    record = 0;
    state = GameState.start;
  }
}
