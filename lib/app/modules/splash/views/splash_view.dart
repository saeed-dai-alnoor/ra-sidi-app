import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: const Color(0xFFFFA726),
      systemNavigationBarColor: Colors.white,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // من فوق
            end: Alignment.bottomCenter, // لتحت
            colors: [
              Color(0xFFFFA726), // برتقالي
              Color.fromRGBO(226, 218, 218, 0.857), // فاتح رمادي
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(58.0),
                  child: Lottie.asset(
                    'assets/animations/appLoading.json',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
