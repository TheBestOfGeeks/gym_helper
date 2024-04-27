import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gym_helper/app/common/ui/theme_manager/custom_text_styles.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_custom_colors.dart';

class Themes {
  static ThemeData getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      useMaterial3: true,
      extensions: [
        ThemeColors.light,
      ],
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.grey,
      brightness: Brightness.dark,
      useMaterial3: true,
      extensions: [
        ThemeColors.dark,
      ],
    );
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ThemeColors get colorScheme => Theme.of(this).extension<ThemeColors>()!;

  AdaptiveThemeManager<ThemeData> get adaptiveTheme => AdaptiveTheme.of(this);

  CustomTextStyles get customTextStyles =>
      CustomTextStyles(themeColors: colorScheme);
}
