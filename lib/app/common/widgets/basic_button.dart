import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);

    return Material(
      borderRadius: borderRadius,
      elevation: 10,
      shadowColor: Colors.pink,
      color: Colors.orange,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        highlightColor: Colors.pinkAccent,
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
                Colors.redAccent,
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
