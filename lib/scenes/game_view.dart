import 'package:flappy_dash_ce/engine/painter/game_painter.dart';
import 'package:flappy_dash_ce/engine/utils/size.dart';
import 'package:flappy_dash_ce/game/game_controller.dart';
import 'package:flappy_dash_ce/ui/button.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  GameViewState createState() => GameViewState();
}

class GameViewState extends State<GameView> {
  late GameController gameController;

  @override
  void initState() {
    gameController = GameController(show: false);
    gameController.init();
    gameController.onTick = () => setState(() {});
    gameController.run();
    super.initState();
  }

  @override
  void dispose() {
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
        width: SizeManager.instance.screen.width,
        height: SizeManager.instance.screen.height,
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
