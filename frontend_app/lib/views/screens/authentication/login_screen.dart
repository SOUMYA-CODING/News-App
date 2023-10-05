import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/constants/image_strings.dart';
import 'package:frontend_app/constants/text_strings.dart';
import 'package:frontend_app/controller/auth/login_controller.dart';
import 'package:frontend_app/routes/route_names.dart';
import 'package:frontend_app/views/widgets/common/custom_button.dart';
import 'package:frontend_app/views/widgets/common/custom_text_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5.0.wp, top: 6.0.hp, right: 5.0.wp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ENImages.appLogo,
                  width: 80,
                ),
                SizedBox(height: 5.0.hp),
                Text(
                  ENText.loginWelcome,
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.0.hp),
                const Text(ENText.loginHeadline),
                SizedBox(height: 5.0.hp),
                CustomTextField(
                  controller: loginController.eMailController,
                  hintText: "Username",
                  obscureText: false,
                  readOnly: false,
                  keyboardType: TextInputType.text,
                  prefixIcon:
                      const Icon(FluentSystemIcons.ic_fluent_mail_regular),
                ),
                SizedBox(height: 2.0.hp),
                CustomTextField(
                  controller: loginController.passwordController,
                  hintText: "Password",
                  obscureText: false,
                  readOnly: false,
                  keyboardType: TextInputType.text,
                  prefixIcon:
                      const Icon(FluentSystemIcons.ic_fluent_lock_regular),
                  suffixIcon:
                      const Icon(FluentSystemIcons.ic_fluent_eye_show_filled),
                ),
                SizedBox(height: 2.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onChanged: (value) {},
                          activeColor: ENColors.primaryColor,
                        ),
                        const Text(ENText.loginRememberMe),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(RouteName.passwordScreen),
                      child: const Text(
                        ENText.loginPasswordReset,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0.hp),
                CustomButton(
                  isOulined: false,
                  onPressed: () => loginController.authenticateUser(),
                  widget: Obx(() {
                    if (loginController.isLoading.value) {
                      return const CircularProgressIndicator();
                    } else {
                      return Text(
                        ENText.loginSignIn.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  }),
                ),
                SizedBox(height: 2.0.hp),
                CustomButton(
                  isOulined: true,
                  onPressed: () => Get.toNamed(RouteName.registrationScreen),
                  widget: Text(
                    ENText.loginCreateAccount.toUpperCase(),
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
