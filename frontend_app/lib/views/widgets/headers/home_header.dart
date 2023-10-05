import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/constants/text_strings.dart';
import 'package:frontend_app/controller/dashboard/tabs/home_tab_controller.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ENText.appName,
              style: TextStyle(
                color: ENColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0.sp,
              ),
            ),
            Text(HomeTabController.instance.formattedDate.value),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Stack(
            children: [
              const Icon(FluentSystemIcons.ic_fluent_alert_regular),
              Positioned(
                right: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: ENColors.primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
