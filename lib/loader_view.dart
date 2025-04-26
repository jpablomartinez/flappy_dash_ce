import 'package:flappy_dash_ce/core/game_state.dart';
import 'package:flappy_dash_ce/core/loader_painter.dart';
import 'package:flappy_dash_ce/game_view.dart';
import 'package:flappy_dash_ce/game/loader_controller.dart';
import 'package:flutter/material.dart';

class LoaderScreenView extends StatefulWidget {
  const LoaderScreenView({super.key});

  @override
  LoaderScreenViewState createState() => LoaderScreenViewState();
}

class LoaderScreenViewState extends State<LoaderScreenView> {
  late LoaderController loaderController;
  late GameState gameState;

  /*void _onTick(Duration elapsed) {
    final now = DateTime.now().microsecondsSinceEpoch;
    final dt = (now - _lastTime) / 1e6;
    _lastTime = now;
    loaderController.update(dt);
    if (loaderController.progress >= 100) {
      loaderController.stop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameView()));
    }
    setState(() {});
  }*/

  @override
  void initState() {
    gameState = GameState.loading;
    loaderController = LoaderController();
    loaderController.loadAssets();
    loaderController.onTick = () {
      setState(() {});
      if (loaderController.progress >= 100) {
        loaderController.stop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameView()));
      }
    };
    loaderController.run();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: LoaderPainter(
            ui: [loaderController.loader],
            gameState: gameState,
            size: size,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}
