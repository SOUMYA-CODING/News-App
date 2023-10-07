import 'package:flutter/material.dart';

class CustomLoadingBox extends StatelessWidget {
  const CustomLoadingBox({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black45,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(height: 16.0),
          Text(
            "Loading...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}