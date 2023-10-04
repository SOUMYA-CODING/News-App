// ignore_for_file: body_might_complete_normally_nullable

import 'package:frontend_app/routes/route_names.dart';
import 'package:frontend_app/views/screens/authentication/login_screen.dart';
import 'package:frontend_app/views/screens/authentication/password_reset_screen.dart';
import 'package:frontend_app/views/screens/authentication/registration_screen.dart';
import 'package:frontend_app/views/screens/dashboard/dashboard_screen.dart';
import 'package:frontend_app/views/screens/start/onboarding_screen.dart';
import 'package:frontend_app/views/screens/start/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static final List<GetPage> routes = [
    // Start
    GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: RouteName.onboardingScreen,
      page: () => const OnboardingScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    // Auth
    GetPage(
      name: RouteName.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RouteName.registrationScreen,
      page: () => const RegistrationScreen(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: RouteName.passwordScreen,
      page: () => const PasswordResetScreen(),
      transition: Transition.downToUp,
    ),

    // Dashboard
    GetPage(
      name: RouteName.dashboardScreen,
      page: () => const DashboardTabScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
