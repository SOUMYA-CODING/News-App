import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(9.0.wp),
      child: Column(
        children: [
          SizedBox(
            height: 10.0.hp,
          ),
          Image(
            image: AssetImage(imagePath),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0.sp,
            ),
          ),
          SizedBox(
            height: 3.0.hp,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
