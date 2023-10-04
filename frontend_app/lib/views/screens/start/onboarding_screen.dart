import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/constants/image_strings.dart';
import 'package:frontend_app/constants/sizes.dart';
import 'package:frontend_app/constants/text_strings.dart';
import 'package:frontend_app/controller/onboarding/onboarding_controller.dart';
import 'package:frontend_app/views/widgets/onboarding/onboarding_button.dart';
import 'package:frontend_app/views/widgets/onboarding/onboarding_dot_indicator.dart';
import 'package:frontend_app/views/widgets/onboarding/onboarding_page.dart';
import 'package:frontend_app/views/widgets/onboarding/onboarding_skip.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnboardingPage(
                  imagePath: ENImages.onboardingImage1,
                  title: ENText.onboardingHeadling1,
                  description: ENText.onboardingDescription1,
                ),
                OnboardingPage(
                  imagePath: ENImages.onboardingImage2,
                  title: ENText.onboardingHeadling2,
                  description: ENText.onboardingDescription2,
                ),
                OnboardingPage(
                  imagePath: ENImages.onboardingImage3,
                  title: ENText.onboardingHeadling3,
                  description: ENText.onboardingDescription3,
                ),
              ],
            ),
            const OnboardingSkip(),
            Positioned(
              bottom: 5.0.wp,
              left: 0,
              right: 0,
              child: const Padding(
                padding: ENSizes.defaultLayoutPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OnboardingDotIndicator(),
                    OnboardingButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
