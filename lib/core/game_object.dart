import 'package:flutter/material.dart';

abstract class GameObject {
  void update(double deltaTime);
  void render(Canvas canvas);
}
