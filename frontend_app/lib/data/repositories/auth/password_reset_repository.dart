import 'package:frontend_app/constants/api_constants.dart';
import 'package:frontend_app/network/dio_client.dart';

class PasswordResetRepository {
  final DioClient dioClient = DioClient();

  Future<Map<String, dynamic>> sendPasswordResetLink(String email) async {
    try {
      final response = await dioClient.post(
        "${ENApi.apiUrl}${ENApi.passwordReset}",
        data: {
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        return {"success": true, "message": "${response.data["message"]}"};
      } else {
        return {"success": false, "message": "${response.data["message"]}"};
      }
    } catch (e) {
      return {"success": false, "message": "Something went wrong"};
    }
  }
}
