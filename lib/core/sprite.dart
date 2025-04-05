import 'dart:ui' as ui;

import 'package:flutter/services.dart';

Future<ui.Image> loadSprite(String path) async {
  final data = await rootBundle.load(path);
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  return frame.image;
}
