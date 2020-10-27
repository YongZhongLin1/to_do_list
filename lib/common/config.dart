import 'package:flutter/material.dart';

class Config {
  // ignore: unused_field
  static double _screenWidth;
  static double _screenHeight;
  static double textMultiplier;

  static void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
    }
    textMultiplier = _screenHeight / 100;
  }
}
