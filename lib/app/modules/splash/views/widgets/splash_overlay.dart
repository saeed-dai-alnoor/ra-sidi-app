import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashOverlay extends StatelessWidget {
  const SplashOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(
        alpha: 0.5,
      ), // خلفية شفافة (ممكن تخليها Colors.transparent)
      child: Center(
        child: Lottie.asset(
          'assets/animations/appLoading.json',
          width: 125,
          height: 125,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
