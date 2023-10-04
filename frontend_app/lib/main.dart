import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/routes/app_route.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: ENColors.backgroundColor),
      debugShowCheckedModeBanner: true,
      getPages: AppRoute.routes,
    ),
  );
}
