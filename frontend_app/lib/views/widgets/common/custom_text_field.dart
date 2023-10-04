import 'package:flutter/material.dart';
import 'package:frontend_app/constants/sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? callback;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    required this.obscureText,
    required this.readOnly,
    required this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        if (labelText != null) ENSizes.smallSpace,
        TextFormField(
          onTap: callback,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintText: hintText,
            prefixIconColor: Colors.black,
            suffixIconColor: Colors.black,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          obscureText: obscureText,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
