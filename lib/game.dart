import 'package:flappy_dash_ce/core/game_painter.dart';
import 'package:flappy_dash_ce/game/game_controller.dart';
import 'package:flappy_dash_ce/ui/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  GameViewState createState() => GameViewState();
}

class GameViewState extends State<GameView> with SingleTickerProviderStateMixin {
  late Ticker ticker;
  late GameController gameController;

  void _onTick(Duration elapsed) {
    gameController.onTick(elapsed);
    setState(() {});
  }

  @override
  void initState() {
    gameController = GameController(show: true);
    gameController.init();
    ticker = createTicker(_onTick)..start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (event) {
        final localPosition = event.localPosition;
        if (!gameController.isGameOver()) {
          if (!gameController.isScreenTouched) {
            gameController.play();
          } else {
            gameController.dash.flap();
          }
        }
        for (final uiElement in gameController.ui) {
          if (uiElement is Button) {
            if (uiElement.checkOnTap(localPosition)) {
              uiElement.onTap();
            }
          }
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/basic_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomPaint(
          painter: GamePainter(
            gameObjects: gameController.gameObjects,
            ui: gameController.ui,
            gameState: gameController.gameState,
          ),
          size: Size.infinite,
        ),
      ),
    ));
  }
}
