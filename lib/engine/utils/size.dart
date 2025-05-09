import 'dart:ui';

import 'package:flappy_dash_ce/configuration/game_config.dart';

class SizeManager {
  static final SizeManager instance = SizeManager._internal();
  factory SizeManager() => instance;
  SizeManager._internal();

  late Size screen;
  final GameConfig gameConfig = GameConfig();

  void setSizeScreen(Size s) {
    screen = s;
  }

  double getFloorYPosition() {
    return (SizeManager.instance.screen.height - SizeManager.instance.screen.height * gameConfig.floorHeightFactor);
  }

  double getFloorXPosition() {
    return screen.width * gameConfig.floorInitialXPositionFactor;
  }

  double getDashInitialYPosition() {
    return screen.height * gameConfig.dashInitialYPositionFactor;
  }

  double getDashInitialXPosition() {
    return 50;
  }

  double getWhiteSpace() {
    return screen.height * gameConfig.whiteSpaceFactor;
  }

  double getFloorHeight() {
    return SizeManager.instance.screen.height * gameConfig.floorHeightFactor;
  }
}
