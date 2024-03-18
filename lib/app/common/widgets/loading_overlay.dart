import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Stack(
        children: [
          child,
          Visibility(
            visible: isLoading,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
