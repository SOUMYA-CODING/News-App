import 'package:flutter/material.dart';
import 'package:frontend_app/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  
  runApp(
    GetMaterialApp(
      // theme: ThemeData(scaffoldBackgroundColor: ENColors.backgroundColor),
      debugShowCheckedModeBanner: true,
      getPages: AppRoute.routes,
    ),
  );
}
