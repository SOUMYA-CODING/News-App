import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/views/widgets/common/custom_button.dart';
import 'package:frontend_app/views/widgets/common/custom_text_field.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    return Scaffold(
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
              SizedBox(height: 5.0.hp),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: email,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "First Name",
                      prefixIcon: const Icon(
                          FluentSystemIcons.ic_fluent_person_regular),
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: email,
                      obscureText: false,
                      readOnly: false,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Last Name",
                      prefixIcon: const Icon(
                          FluentSystemIcons.ic_fluent_person_regular),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.0.hp),
              CustomTextField(
                controller: email,
                obscureText: false,
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                hintText: "Username",
                prefixIcon:
                    const Icon(FluentSystemIcons.ic_fluent_person_regular),
              ),
              SizedBox(height: 2.0.hp),
              CustomTextField(
                controller: email,
                obscureText: false,
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                hintText: "E-mail",
                prefixIcon:
                    const Icon(FluentSystemIcons.ic_fluent_mail_regular),
              ),
              SizedBox(height: 2.0.hp),
              CustomTextField(
                controller: email,
                obscureText: false,
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                hintText: "Phone Number",
                prefixIcon:
                    const Icon(FluentSystemIcons.ic_fluent_phone_regular),
              ),
              SizedBox(height: 2.0.hp),
              CustomTextField(
                controller: email,
                obscureText: false,
                readOnly: false,
                keyboardType: TextInputType.emailAddress,
                hintText: "Password",
                prefixIcon:
                    const Icon(FluentSystemIcons.ic_fluent_lock_regular),
              ),
              CustomButton(
                isOulined: false,
                onPressed: () {},
                widget: const Text("Send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
