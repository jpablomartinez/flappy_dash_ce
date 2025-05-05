import 'package:flappy_dash_ce/engine/core/game_object.dart';
import 'package:flappy_dash_ce/engine/utils/size.dart';
import 'package:flappy_dash_ce/game/pipe.dart';
import 'package:flappy_dash_ce/game/point_collider.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class PipeGenerator {
  bool isAlive;
  double elapsedTime = 0;
  List<GameObject> obj;
  ui.Image? upperSprite;
  ui.Image? lowerSprite;
  final random = math.Random(DateTime.now().microsecondsSinceEpoch);

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
    double upperYSize = random.nextInt((SizeManager.instance.screen.height * 0.32).toInt()) + 50;
    double lowerYSize = SizeManager.instance.getFloorYPosition() - SizeManager.instance.getWhiteSpace() - upperYSize;
    Size upperSize = Size(SizeManager.instance.screen.width * 0.2, upperYSize);
    Size lowerSize = Size(SizeManager.instance.screen.width * 0.2, lowerYSize);
    Pipe upperPipe = Pipe(
      upperSprite!,
      Offset(SizeManager.instance.screen.width, 0),
      upperSize,
    );
    Pipe lowerPipe = Pipe(
      lowerSprite!,
      Offset(
        SizeManager.instance.screen.width,
        upperYSize + SizeManager.instance.getWhiteSpace(),
      ),
      lowerSize,
    );
    PointCollider pc = PointCollider(
      Offset(SizeManager.instance.screen.width, upperYSize),
      Size(
        SizeManager.instance.screen.width * 0.2,
        SizeManager.instance.getWhiteSpace(),
      ),
    );
    obj.addAll([upperPipe, pc, lowerPipe]);
  }

  void generatePipes(double dt) {
    elapsedTime += dt;
    if (elapsedTime > 1.8) {
      generatePipe();
      elapsedTime = 0;
    }
  }

  void clearPipes() {
    for (final o in obj) {
      if (o is Pipe || o is PointCollider) {
        o.markedToDelete = true;
      }
    }
    obj.removeWhere((o) => o.markedToDelete);
  }
}
