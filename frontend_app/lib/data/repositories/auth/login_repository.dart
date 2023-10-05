import 'package:frontend_app/config/app_preferences.dart';
import 'package:frontend_app/constants/api_constants.dart';
import 'package:frontend_app/data/models/user_model.dart';
import 'package:frontend_app/network/dio_client.dart';

class LoginRepository {
  final DioClient dioClient = DioClient();

  Future<bool> authenticateUser(String username, String password) async {
    try {
      final response = await dioClient.post(
        "${ENApi.apiUrl}${ENApi.login}",
        data: {
          "username": username,
          "password": password,
        },
      );

      print(response.data);

      if (response.statusCode == 200) {
        final accessToken = response.data["access_token"] as String;
        print("Access token: $accessToken");
        final userData = response.data["data"];
        print("Access token: $accessToken | userData : $userData");

        await AppPreferences.saveAccessToken(accessToken);
        await AppPreferences.saveUserData(userData);
        await AppPreferences.setLoggedIn(true);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
