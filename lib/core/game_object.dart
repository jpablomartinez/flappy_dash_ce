import 'package:flutter/material.dart';

abstract class GameObject {
  bool markedToDelete = false;
  void update(double deltaTime);
  void render(Canvas canvas);
}
