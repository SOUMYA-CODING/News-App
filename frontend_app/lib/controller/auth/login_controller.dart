import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/data/repositories/auth/login_repository.dart';
import 'package:frontend_app/routes/route_names.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final LoginRepository loginRepository = LoginRepository();

  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool rememberMe = false.obs;

  var isLoading = false.obs;

  void showSnackbar(String message) {
    Get.snackbar("Earthy News", message, margin: EdgeInsets.all(3.5.wp));
  }

  Future<void> authenticateUser() async {
    final username = eMailController.text.trim();
    final password = passwordController.text.trim();

    // Validate
    if (username.isEmpty || password.isEmpty) {
      showSnackbar("Please fill in all fields.");
      return;
    }

    try {
      isLoading(true);

      final isAuthenticated = await loginRepository.authenticateUser(
          username, password, rememberMe.value);

      if (isAuthenticated["success"]) {
        showSnackbar(isAuthenticated["message"]);
        Get.offNamed(RouteName.dashboardScreen);
      } else {
        showSnackbar(isAuthenticated["message"]);
      }
    } catch (e) {
      showSnackbar("Something went wrong!!");
    } finally {
      isLoading(false);
    }
  }
}
