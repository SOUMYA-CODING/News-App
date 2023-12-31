import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(scaffoldBackgroundColor: ENColors.backgroundColor),
      getPages: AppRoute.routes,
    ),
  );
}
