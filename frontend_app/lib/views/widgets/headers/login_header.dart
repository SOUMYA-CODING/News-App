import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/constants/image_strings.dart';
import 'package:frontend_app/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ENImages.appLogo,
          width: 80,
        ),
        SizedBox(height: 5.0.hp),
        Text(
          ENText.loginWelcome,
          style: TextStyle(
            fontSize: 20.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.0.hp),
        const Text(ENText.loginHeadline),
      ],
    );
  }
}