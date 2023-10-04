import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/controller/onboarding/onboarding_controller.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => OnBoardingController.instance.nextPage(),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
        shape: MaterialStateProperty.all(const CircleBorder()),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(ENColors.primaryColor),
      ),
      child: const Icon(
        Icons.arrow_forward_ios,
      ),
    );
  }
}
