import 'package:flutter/widgets.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_custom_colors.dart';

class CustomTextStyles {
  late ThemeColors themeColors;
  CustomTextStyles({
    required this.themeColors,
  });

  TextStyle get label => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.07,
        fontFamily: 'Rockwell',
        color: themeColors.labelTextColor,
      );
}
