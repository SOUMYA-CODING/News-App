import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/controller/auth/registartion_controller.dart';
import 'package:frontend_app/views/widgets/common/custom_button.dart';
import 'package:frontend_app/views/widgets/common/custom_loading_box.dart';
import 'package:frontend_app/views/widgets/common/custom_text_field.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registrationController = Get.put(RegistrationController());

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
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's create your account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3.0.hp),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller:
                                registrationController.firstNameController,
                            obscureText: false,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                            hintText: "First Name",
                            prefixIcon: const Icon(
                                FluentSystemIcons.ic_fluent_person_regular),
                          ),
                        ),
                        SizedBox(width: 2.0.wp),
                        Expanded(
                          child: CustomTextField(
                            controller:
                                registrationController.lastNameController,
                            obscureText: false,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                            hintText: "Last Name",
                            prefixIcon: const Icon(
                                FluentSystemIcons.ic_fluent_person_regular),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0.hp),
                    CustomTextField(
                      controller: registrationController.usernameController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      hintText: "Username",
                      prefixIcon: const Icon(
                          FluentSystemIcons.ic_fluent_person_regular),
                    ),
                    SizedBox(height: 2.0.hp),
                    CustomTextField(
                      controller: registrationController.eMailController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "E-mail",
                      prefixIcon:
                          const Icon(FluentSystemIcons.ic_fluent_mail_regular),
                    ),
                    SizedBox(height: 2.0.hp),
                    CustomTextField(
                      controller: registrationController.phoneNumberController,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.phone,
                      hintText: "Phone Number",
                      prefixIcon:
                          const Icon(FluentSystemIcons.ic_fluent_phone_regular),
                    ),
                    SizedBox(height: 2.0.hp),
                    CustomTextField(
                      controller: registrationController.passwordController,
                      obscureText: true,
                      readOnly: false,
                      keyboardType: TextInputType.text,
                      hintText: "Password",
                      prefixIcon:
                          const Icon(FluentSystemIcons.ic_fluent_lock_regular),
                    ),
                    SizedBox(height: 2.0.hp),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: registrationController.isChecked.value,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (bool? value) {
                              if (value != null) {
                                registrationController.isChecked.value = value;
                              }
                            },
                            activeColor: ENColors.primaryColor,
                          ),
                        ),
                        const Text.rich(
                          TextSpan(
                            text: 'I agree to',
                            children: [
                              WidgetSpan(child: SizedBox(width: 2)),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                ),
                              ),
                              WidgetSpan(child: SizedBox(width: 2)),
                              TextSpan(
                                text: 'and',
                              ),
                              WidgetSpan(child: SizedBox(width: 2)),
                              TextSpan(
                                text: 'Terms of use',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0.hp),
                    CustomButton(
                      isOulined: false,
                      onPressed: () => registrationController.registernewUser(),
                      widget: Text(
                        "Create account".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (registrationController.isLoading.value) {
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
