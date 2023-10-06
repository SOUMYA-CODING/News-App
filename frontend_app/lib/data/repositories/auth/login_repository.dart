import 'package:frontend_app/config/app_preferences.dart';
import 'package:frontend_app/constants/api_constants.dart';
import 'package:frontend_app/data/models/user_model.dart';
import 'package:frontend_app/network/dio_client.dart';

class LoginRepository {
  final DioClient dioClient = DioClient();

  Future<Map<String, dynamic>> authenticateUser(
      String username, String password, bool rememberMe) async {
    try {
      final response = await dioClient.post(
        "${ENApi.apiUrl}${ENApi.login}",
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final userData = UserModel.fromJson(response.data);

        if (rememberMe) {
          await AppPreferences.saveUserData(userData);
          await AppPreferences.setLoggedIn(true);
        }
        return {"success": true, "message": "${response.data["message"]}"};
      } else {
        return {"success": false, "message": "${response.data["message"]}"};
      }
    } catch (e) {
      return {"success": false, "message": "Something went wrong"};
    }
  }
}
