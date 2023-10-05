import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final bool isOulined;
  final VoidCallback onPressed;
  final Widget widget;

  const CustomButton({
    super.key,
    required this.isOulined,
    required this.onPressed,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: isOulined
              ? MaterialStateProperty.all(Colors.transparent)
              : MaterialStateProperty.all(ENColors.primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: ENColors.primaryColor),
            ),
          ),
        ),
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}
