// ignore_for_file: dead_code

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/controller/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardTabScreen extends StatefulWidget {
  const DashboardTabScreen({super.key});

  @override
  State<DashboardTabScreen> createState() => _DashboardTabScreenState();
}

class _DashboardTabScreenState extends State<DashboardTabScreen> {
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.isPremium
          ? FloatingActionButton(
              backgroundColor: ENColors.primaryColor,
              onPressed: () {},
              child: const Icon(FluentSystemIcons.ic_fluent_add_regular),
            )
          : null,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 9.0.sp,
          unselectedFontSize: 9.0.sp,
          selectedItemColor: ENColors.primaryColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: controller.currentTabIndex.value,
          onTap: (index) => controller.onTap(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                FluentSystemIcons.ic_fluent_home_regular,
              ),
              label: 'Home',
              activeIcon: Icon(
                FluentSystemIcons.ic_fluent_home_filled,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FluentSystemIcons.ic_fluent_search_regular,
              ),
              label: 'Explore',
              activeIcon: Icon(
                FluentSystemIcons.ic_fluent_search_filled,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FluentSystemIcons.ic_fluent_bookmark_regular,
              ),
              label: 'Saved',
              activeIcon: Icon(
                FluentSystemIcons.ic_fluent_bookmark_filled,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FluentSystemIcons.ic_fluent_person_regular,
              ),
              label: 'Profile',
              activeIcon: Icon(
                FluentSystemIcons.ic_fluent_person_filled,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 3.6.wp, top: 2.6.hp, right: 3.6.wp),
          child: Obx(
            () => controller.tabScreen[controller.currentTabIndex.value],
          ),
        ),
      ),
    );
  }
}
