import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/controller/auth/password_reset_controller.dart';
import 'package:frontend_app/views/widgets/common/custom_button.dart';
import 'package:frontend_app/views/widgets/common/custom_loading_box.dart';
import 'package:frontend_app/views/widgets/common/custom_text_field.dart';
import 'package:get/get.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordResetController = Get.put(PasswordResetController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5.0.wp, right: 5.0.wp),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.0.hp),
                  const Text(
                      "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link"),
                  SizedBox(height: 3.0.hp),
                  CustomTextField(
                    controller: passwordResetController.eMailController,
                    obscureText: false,
                    readOnly: false,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "E-mail",
                    prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_mail_read_regular),
                  ),
                  SizedBox(height: 2.0.hp),
                  CustomButton(
                    isOulined: false,
                    onPressed: () => passwordResetController.resetPassword(),
                    widget: Text(
                      "Send".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (passwordResetController.isLoading.value) {
                  return CustomLoadingBox(context: context);
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
