import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/core/game_painter.dart';
import 'package:flappy_dash_ce/core/sprite.dart';
import 'package:flappy_dash_ce/game/dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> with SingleTickerProviderStateMixin {
  List<GameObject> gameObjects = [];
  late Ticker ticker;
  late Dash dash;
  double lastTime = 0.0;

  void _onTick(Duration elapsed) {
    final double dt = (elapsed.inMilliseconds - lastTime) / 1000;
    lastTime = elapsed.inMilliseconds.toDouble();
    for (final obj in gameObjects) {
      obj.update(dt);
    }
    setState(() {
      //
    });
  }

  @override
  void initState() {
    loadSprite('assets/sprites/dash_still.png').then((sprite) => {
          dash = Dash(
            sprite: sprite,
            position: const Offset(100, 100),
            size: const Size(50, 50),
          ),
          gameObjects.add(dash),
        });
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
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: GamePainter(gameObjects: gameObjects),
          size: Size.infinite,
        ),
      ),
    );
  }
}
