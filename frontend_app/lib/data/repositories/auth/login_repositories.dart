import 'package:frontend_app/constants/api_constants.dart';
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

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
