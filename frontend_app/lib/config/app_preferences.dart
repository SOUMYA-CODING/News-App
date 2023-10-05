import 'package:frontend_app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String keyAccessToken = 'access_token';
  static const String keyUserData = 'user_data';
  static const String keyLoggedInStatus = 'logged_in_status';
  static const String keyOnboardingStatus = 'onboarding_status';

  static Future<void> saveOnboardingStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyOnboardingStatus, status);
  }

  static Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyOnboardingStatus) ?? false;
  }

  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("keyAccessToken", token);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("keyAccessToken");
  }

  static Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = userModelToJson(user);
    prefs.setString("keyUserData", userDataJson);
  }

  static Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString("keyUserData");
    if (userDataJson != null) {
      return userModelFromJson(userDataJson);
    } else {
      return null;
    }
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("keyUserData");
  }

  static Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("keyLoggedInStatus", isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("keyLoggedInStatus") ?? false;
  }

  static Future<void> clearLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("keyLoggedInStatus");
  }

  static Future<void> logout() async {
    await clearUserData();
    await clearLoggedInStatus();
  }
}
