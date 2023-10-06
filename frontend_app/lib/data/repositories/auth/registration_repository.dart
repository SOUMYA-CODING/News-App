import 'package:frontend_app/config/app_preferences.dart';
import 'package:frontend_app/constants/api_constants.dart';
import 'package:frontend_app/data/models/user_model.dart';
import 'package:frontend_app/network/dio_client.dart';

class RegistrationRepository {
  final DioClient dioClient = DioClient();

  Future<bool> createUser(String firstName, String lastName, String email,
      String phoneNumber, String username, String password) async {
    try {
      final response = await dioClient.post(
        "${ENApi.apiUrl}${ENApi.registration}",
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone_number": phoneNumber,
          "user_type": "regular",
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        // print("response ${response.data}");
        final userData = UserModel.fromJson(response.data);
        await AppPreferences.saveUserData(userData);
        // await AppPreferences.setLoggedIn(true);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
