import 'package:frontend_app/constants/api_constants.dart';
import 'package:frontend_app/network/dio_client.dart';

class RegistrationRepository {
  final DioClient dioClient = DioClient();

  Future<bool> createUser(String firstName, String lastName, String email, String username, String password) async {
    try {
      final response = await dioClient.post(
        "${ENApi.apiUrl}${ENApi.registration}",
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "user_type": "regular",
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
