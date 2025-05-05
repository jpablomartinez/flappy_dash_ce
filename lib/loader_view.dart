import 'package:flappy_dash_ce/engine/core/game_state.dart';
import 'package:flappy_dash_ce/engine/painter/loader_painter.dart';
import 'package:flappy_dash_ce/game/logo.dart';
import 'package:flappy_dash_ce/engine/utils/size.dart';
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
  late Logo logo;
  late GameState gameState;
  late SizeManager sizeManager;

  @override
  void initState() {
    logo = Logo();
    sizeManager = SizeManager();
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
    sizeManager.setSizeScreen(size);
    logo.size = size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: LoaderPainter(
            ui: [loaderController.loader, logo],
            gameState: gameState,
            size: size,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}
