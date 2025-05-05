import 'dart:ui';

class SizeManager {
  static final SizeManager instance = SizeManager._internal();
  factory SizeManager() => instance;
  SizeManager._internal();

  late Size screen;

  void setSizeScreen(Size s) {
    screen = s;
  }

  double getFloorYPosition() {
    return (SizeManager.instance.screen.height - SizeManager.instance.screen.height * 0.1957);
  }

  double getFloorXPosition() {
    return screen.width * 0.7;
  }

  double getDashInitialYPosition() {
    return screen.height * 0.43;
  }

  double getDashInitialXPosition() {
    return 50;
  }

  double getWhiteSpace() {
    return screen.height * 0.15;
  }

  double getFloorHeight() {
    return SizeManager.instance.screen.height * 0.1957;
  }
}
