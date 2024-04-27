import 'package:flutter/material.dart';
import 'package:gym_helper/app/common/ui/theme_manager/theme_manager.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    Key? key,
    required this.text,
    this.elevation = 10,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final double elevation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    final buttonColor = context.colorScheme.mainRedColor;

    return Material(
      borderRadius: borderRadius,
      elevation: elevation,
      shadowColor: buttonColor,
      color: Colors.orange,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        highlightColor: buttonColor,
        splashFactory: NoSplash.splashFactory,
        child: Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.color,
            borderRadius: borderRadius,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 20,
                blurStyle: BlurStyle.outer,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.black.withBlue(50),
                buttonColor,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 48.0,
              vertical: 12.0,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
