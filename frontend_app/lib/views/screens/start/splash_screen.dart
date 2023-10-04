import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_app/constants/image_strings.dart';
import 'package:frontend_app/routes/route_names.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteName.onboardingScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            ENImages.appLogo,
            width: 120,
          ),
        ),
      ),
    );
  }
}
