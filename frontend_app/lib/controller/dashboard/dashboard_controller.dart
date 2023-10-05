import 'package:frontend_app/config/app_preferences.dart';
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
  bool isPremium = false;

  @override
  void onInit() {
    super.onInit();
    loadIsPremiumStatus();
  }

  void onTap(index) => currentTabIndex.value = index;

  Future<void> loadIsPremiumStatus() async {
    final userModel = await AppPreferences.getUserData();
    if (userModel != null) {
      isPremium = userModel.data.isPremium;
      update();
    }
  }
}
