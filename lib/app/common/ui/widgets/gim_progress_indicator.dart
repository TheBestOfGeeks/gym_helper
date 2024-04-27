import 'package:flutter/cupertino.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_manager.dart';

class GimProgressIndicator extends StatelessWidget {
  const GimProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20,
        color: context.colorScheme.mainRedColor,
      ),
    );
  }
}
