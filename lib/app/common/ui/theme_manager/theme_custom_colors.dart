import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color filterButtonFillColor;
  final Color labelTextColor;
  final Color mainRedColor;

  const ThemeColors({
    required this.filterButtonFillColor,
    required this.labelTextColor,
    required this.mainRedColor,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? filterButtonFillColor,
    Color? labelTextColor,
    Color? mainRedColor,
  }) {
    return ThemeColors(
      filterButtonFillColor:
          filterButtonFillColor ?? this.filterButtonFillColor,
      labelTextColor: labelTextColor ?? this.labelTextColor,
      mainRedColor: mainRedColor ?? this.mainRedColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      filterButtonFillColor:
          Color.lerp(filterButtonFillColor, other.filterButtonFillColor, t)!,
      labelTextColor: Color.lerp(labelTextColor, other.labelTextColor, t)!,
      mainRedColor: Color.lerp(mainRedColor, other.mainRedColor, t)!,
    );
  }

  static ThemeColors get light => const ThemeColors(
        filterButtonFillColor: Colors.white,
        labelTextColor: Colors.black,
        mainRedColor: Color(0xffF23847),
      );

  static ThemeColors get dark => const ThemeColors(
        filterButtonFillColor: Colors.black,
        labelTextColor: Colors.white,
        mainRedColor: Colors.black,
      );
}
