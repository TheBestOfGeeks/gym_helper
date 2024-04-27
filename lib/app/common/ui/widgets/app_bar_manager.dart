import 'package:flutter/material.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_manager.dart';

class AppBarManager {
  static SliverAppBar getSliverAppBar(
    BuildContext context, {
    bool backButton = true,
  }) {
    return SliverAppBar(
      automaticallyImplyLeading: backButton,
      backgroundColor: context.colorScheme.mainRedColor,
      foregroundColor: Colors.white,
    );
  }
}
