import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class GameConfig {
  static final GameConfig _instance = GameConfig._internal();
  factory GameConfig() => _instance;
  GameConfig._internal();

  var logger = Logger();

  late double vibrationAmplitude;

  Future<void> load(String path) async {
    try {
      final raw = await rootBundle.loadString(path);
      final configuration = json.decode(raw);
      vibrationAmplitude = (configuration['vibration']['amplitude'] as num).toDouble();
      logger.d('loaded!');
    } catch (err) {
      logger.e(err);
    }
  }
}
