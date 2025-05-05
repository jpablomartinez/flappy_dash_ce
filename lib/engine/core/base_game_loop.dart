import 'package:flutter/scheduler.dart';

abstract class BaseGameLoop {
  late final Ticker _ticker;
  Duration previuos = Duration.zero;
  bool isRunning = false;
  void Function()? onTick;

  void update(double dt);
  void dispose() {
    _ticker.dispose();
  }

  void _onTick(Duration now) {
    if (previuos == Duration.zero) {
      previuos = now;
      return;
    }
    final dt = (now - previuos).inMicroseconds / 1e6;
    previuos = now;
    if (isRunning) {
      update(dt);
      onTick?.call();
    }
  }

  void run() {
    isRunning = true;
    previuos = Duration.zero;
    _ticker.start();
  }

  void stop() {
    isRunning = false;
    _ticker.stop();
  }

  BaseGameLoop() {
    _ticker = Ticker(_onTick);
  }
}
