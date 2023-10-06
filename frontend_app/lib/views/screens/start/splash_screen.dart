import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_app/config/app_preferences.dart';
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
      () => navigateUser(),
    );
  }

  Future<void> navigateUser() async {
    final hasCompletedOnboarding = await AppPreferences.getOnboardingStatus();
    final isLoggedIn = await AppPreferences.isLoggedIn();

    if (!hasCompletedOnboarding) {
      await AppPreferences.saveOnboardingStatus(true);
      Get.offNamed(RouteName.onboardingScreen);
    } else if (isLoggedIn) {
      Get.offNamed(RouteName.dashboardScreen);
    } else {
      Get.offNamed(RouteName.loginScreen);
    }
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
