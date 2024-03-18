import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

showToast({required BuildContext context, required String errorMessage}) {
  final systemTopBar = MediaQuery.of(context).padding.top;

  BotToast.cleanAll();
  BotToast.showAnimationWidget(
    toastBuilder: (cancelFunc) {
      return Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: kToolbarHeight + systemTopBar,
        color: const Color(0xffE94551),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              errorMessage,
            ),
          ],
        ),
      );
    },
    wrapToastAnimation: (controller, cancelFunc, widget) {
      return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                curve: Curves.easeInBack,
                parent: controller,
              ),
            ),
            child: child,
          );
        },
        child: widget,
      );
    },
    animationReverseDuration: const Duration(
      milliseconds: 3000,
    ),
    animationDuration: const Duration(
      milliseconds: 300,
    ),
    duration: const Duration(seconds: 4),
  );
}
