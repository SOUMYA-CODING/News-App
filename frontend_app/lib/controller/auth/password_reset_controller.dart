import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/data/repositories/auth/password_reset_repository.dart';
import 'package:frontend_app/routes/route_names.dart';
import 'package:get/get.dart';

class PasswordResetController extends GetxController {
  static PasswordResetController get instance => Get.find();

  final PasswordResetRepository passwordResetRepository =
      PasswordResetRepository();

  TextEditingController eMailController = TextEditingController();

  var isLoading = false.obs;

  void showSnackbar(String message) {
    Get.snackbar("Earthy News", message, margin: EdgeInsets.all(3.5.wp));
  }

  Future<void> resetPassword() async {
    final email = eMailController.text.trim();

    // Validate
    if (email.isEmpty) {
      showSnackbar("Please enter the email");
      return;
    }

    try {
      isLoading(true);
      final isSend = await passwordResetRepository.sendPasswordResetLink(email);

      if (isSend["success"]) {
        Get.defaultDialog(
          barrierDismissible: true,
          title: "Earthy New",
          middleText: isSend["message"],
          radius: 10,
          onConfirm: () => Get.offNamed(RouteName.loginScreen),
        );
      } else {
        showSnackbar(isSend["message"]);
      }
    } catch (e) {
      showSnackbar("Something went wrong!!");
    } finally {
      isLoading(false);
    }
  }
}
