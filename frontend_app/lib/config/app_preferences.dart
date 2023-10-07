import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_app/data/models/user_model.dart';

class AppPreferences {
  static const storage = FlutterSecureStorage();
  static const String keyAccessToken = 'access_token';
  static const String keyUserData = 'user_data';
  static const String keyLoggedInStatus = 'logged_in_status';
  static const String keyOnboardingStatus = 'onboarding_status';

  static Future<void> saveOnboardingStatus(bool status) async {
    await storage.write(key: keyOnboardingStatus, value: status.toString());
  }

  static Future<bool> getOnboardingStatus() async {
    final status = await storage.read(key: keyOnboardingStatus);
    return status == 'true';
  }

  static Future<void> saveUserData(UserModel user) async {
    final userDataJson = userModelToJson(user);
    await storage.write(key: keyUserData, value: userDataJson);
  }

  static Future<UserModel?> getUserData() async {
    final userDataJson = await storage.read(key: keyUserData);
    if (userDataJson != null) {
      return userModelFromJson(userDataJson);
    } else {
      return null;
    }
  }

  static Future<void> clearUserData() async {
    await storage.delete(key: keyUserData);
  }

  static Future<void> setLoggedIn(bool isLoggedIn) async {
    await storage.write(key: keyLoggedInStatus, value: isLoggedIn.toString());
  }

  static Future<bool> isLoggedIn() async {
    final isLoggedIn = await storage.read(key: keyLoggedInStatus);
    return isLoggedIn == 'true';
  }

  static Future<void> clearLoggedInStatus() async {
    await storage.delete(key: keyLoggedInStatus);
  }

  static Future<void> logout() async {
    await clearUserData();
    await clearLoggedInStatus();
  }
}
