import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/data/repositories/auth/registration_repository.dart';
import 'package:frontend_app/routes/route_names.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  final RegistrationRepository registrationRepository =
      RegistrationRepository();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isChecked = false.obs;

  var isLoading = false.obs;

  void showSnackbar(String message) {
    Get.snackbar("Earthy News", message, margin: EdgeInsets.all(3.5.wp));
  }

  Future<void> registernewUser() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final eMail = eMailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Validate
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        eMail.isEmpty ||
        username.isEmpty ||
        password.isEmpty || 
        !isChecked.value) {
      showSnackbar("Please fill in all fields.");
      return;
    }

    try {
      isLoading(true);

      final isAuthenticated = await registrationRepository.createUser(
          firstName, lastName, eMail, username, password);

      if (isAuthenticated) {
        showSnackbar("Login Successfully");
        Get.offNamed(RouteName.dashboardScreen);
      } else {
        showSnackbar("Please enter the data correcty!");
      }
    } catch (e) {
      showSnackbar("Something went wrong!!");
    } finally {
      isLoading(false);
    }
  }
}
