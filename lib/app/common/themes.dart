import 'package:flutter/material.dart';

class Themes {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
    );
  }
}
