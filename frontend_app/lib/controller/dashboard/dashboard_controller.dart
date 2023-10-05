import 'package:frontend_app/views/screens/dashboard/tabs/catgeory_tab.dart';
import 'package:frontend_app/views/screens/dashboard/tabs/home_tab.dart';
import 'package:frontend_app/views/screens/dashboard/tabs/saved_articles_tab.dart';
import 'package:frontend_app/views/screens/dashboard/tabs/settings_tab.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  List tabScreen = [
    const HomeTab(),
    const CategoryTab(),
    const SavedArticlesTab(),
    const SettingsTab(),
  ];

  var currentTabIndex = 0.obs;

  void onTap(index) => currentTabIndex.value = index;
}
