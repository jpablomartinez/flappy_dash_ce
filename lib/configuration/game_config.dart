import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class GameConfig {
  static final GameConfig _instance = GameConfig._internal();
  factory GameConfig() => _instance;
  GameConfig._internal();

  var logger = Logger();

  late double vibrationAmplitude;

  //Floor configuration
  late double floorHeightFactor;
  late double floorInitialXPositionFactor;

  //Pipes Configuration
  late double whiteSpaceFactor;
  late double pipeWidthFactor;
  late double pipeHeightFactor;

  //Bird configuration
  late double birdSizeWidth;
  late double birdSizeHeight;
  late double xBirdInitialPosition;
  late double yBirdInitialPosition;
  late double yLimitPositionFactor;
  late double forceJump;
  late double dashInitialYPositionFactor;

  //Physics configuration
  late double gravity;
  late double impulse;
  late double maxFallSpeed;
  late double maxJumpTime;
  late double maxTiltUp;
  late double maxTiltDown;
  late double tiltLerpSpeed;
  late double fallingTime;
  late double maxFallingTime;

  //Spawner configuration
  late double waitTime;

  Future<void> load(String path) async {
    try {
      final raw = await rootBundle.loadString(path);
      final configuration = json.decode(raw);
      vibrationAmplitude = (configuration['vibration']['amplitude'] as num).toDouble();

      //bird configuration
      birdSizeHeight = (configuration['bird']['size_height'] as num).toDouble();
      birdSizeWidth = (configuration['bird']['size_width'] as num).toDouble();
      xBirdInitialPosition = (configuration['bird']['x_initial_position'] as num).toDouble();
      yBirdInitialPosition = (configuration['bird']['y_initial_position'] as num).toDouble();
      yLimitPositionFactor = (configuration['bird']['y_limit_position_factor'] as num).toDouble();
      forceJump = (configuration['bird']['force_jump'] as num).toDouble();
      dashInitialYPositionFactor = (configuration['bird']['dash_initial_y_position_factor'] as num).toDouble();

      //Physics configuration
      gravity = (configuration['physics']['gravity'] as num).toDouble();
      impulse = (configuration['physics']['impulse'] as num).toDouble();
      maxFallSpeed = (configuration['physics']['max_fall_speed'] as num).toDouble();
      maxJumpTime = (configuration['physics']['max_jump_time'] as num).toDouble();
      maxTiltUp = (configuration['physics']['max_tilt_up'] as num).toDouble();
      maxTiltDown = (configuration['physics']['max_tilt_down'] as num).toDouble();
      tiltLerpSpeed = (configuration['physics']['tilt_lerp_speed'] as num).toDouble();
      fallingTime = (configuration['physics']['falling_time'] as num).toDouble();
      maxFallingTime = (configuration['physics']['max_falling_time'] as num).toDouble();

      //Floor configuration
      floorHeightFactor = (configuration['floor']['floor_height_factor'] as num).toDouble();
      floorInitialXPositionFactor = (configuration['floor']['floor_initial_x_position_factor'] as num).toDouble();

      //Pipe configuration
      whiteSpaceFactor = (configuration['pipe']['white_space_factor'] as num).toDouble();
      pipeWidthFactor = (configuration['pipe']['width_factor'] as num).toDouble();
      pipeHeightFactor = (configuration['pipe']['height_factor'] as num).toDouble();

      //Spawner configuration
      waitTime = (configuration['spawner']['wait_time'] as num).toDouble();

      logger.d('loaded!');
    } catch (err) {
      logger.e(err);
    }
  }
}
