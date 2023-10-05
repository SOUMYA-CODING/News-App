import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/views/widgets/common/custom_text_field.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.ct,
  });

  final TextEditingController ct;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 7,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: CustomTextField(
        controller: ct,
        obscureText: false,
        readOnly: false,
        keyboardType: TextInputType.text,
        hintText: "Search articles",
        prefixIcon: const Icon(
          FluentSystemIcons.ic_fluent_search_filled,
          color: Colors.grey,
        ),
      ),
    );
  }
}
