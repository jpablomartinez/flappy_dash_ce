import 'package:flappy_dash_ce/core/game_object.dart';
import 'package:flappy_dash_ce/game/pipe.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class PipeGenerator {
  bool isAlive;
  double elapsedTime = 0;
  Pipe? upper1;
  Pipe? upper2;
  Pipe? upper3;
  //Pipe? lowerPipe;
  List<GameObject> obj;
  ui.Image? upperSprite;
  ui.Image? lowerSprite;

  PipeGenerator({
    required this.isAlive,
    required this.obj,
  });

  void setUpperSprite(ui.Image sprite) {
    upperSprite = sprite;
  }

  void setLowerSprite(ui.Image sprite) {
    lowerSprite = sprite;
  }

  void generatePipe() {
    final random = math.Random();
    double upperYSize = random.nextInt(180) + 350;
    double lowerYSize = 750 - 140 - upperYSize;
    Size upperSize = Size(85, upperYSize);
    Size lowerSize = Size(85, lowerYSize);
    Pipe upperPipe = Pipe(image: upperSprite!, size: upperSize, position: const Offset(430, 0));
    Pipe lowerPipe = Pipe(image: lowerSprite!, size: lowerSize, position: Offset(430, upperYSize + 140));
    obj.addAll([upperPipe, lowerPipe]);
  }

  void generatePipes(double dt) {
    elapsedTime += dt;
    if (elapsedTime > 1.8) {
      generatePipe();
      elapsedTime = 0;
    }
  }
}
