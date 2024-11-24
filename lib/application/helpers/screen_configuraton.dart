import 'package:flutter/material.dart';

class ScreenConfiguration {
  static ScreenConfiguration? _instance;

  factory ScreenConfiguration() {
    _instance ??= ScreenConfiguration._internal();
    return _instance!;
  }

  ScreenConfiguration._internal();

  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  void initialize(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
  }

  double setWidth(num value) => _screenWidth * (value / 375);

  double setHeight(num value) => _screenHeight * (value / 812);
}
