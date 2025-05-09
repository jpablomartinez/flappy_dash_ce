import 'package:flappy_dash_ce/configuration/game_config.dart';
import 'package:logger/web.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class VibrateController {
  final _logger = Logger();
  final GameConfig gameConfig = GameConfig();

  Future<void> vibrate() async {
    bool canVibrate = await Vibration.hasVibrator();
    if (canVibrate) {
      Vibration.vibrate(
        duration: (gameConfig.vibrationAmplitude).toInt(),
        preset: VibrationPreset.singleShortBuzz,
      );
    } else {
      _logger.d('Device has not vibration support');
    }
  }
}
