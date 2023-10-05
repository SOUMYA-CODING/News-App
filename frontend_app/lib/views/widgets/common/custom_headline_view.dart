import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:get/get.dart';

class CustomHeadlineView extends StatelessWidget {
  final String title;
  final String routePath;

  const CustomHeadlineView({
    super.key,
    required this.title,
    required this.routePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.0.sp),
        ),
        InkWell(
          onTap: () => Get.toNamed(routePath),
          child: const Text(
            "View more",
            style: TextStyle(color: ENColors.primaryColor),
          ),
        ),
      ],
    );
  }
}