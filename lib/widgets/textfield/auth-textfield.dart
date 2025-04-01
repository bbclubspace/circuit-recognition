import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String subText;
  final TextEditingController controller;
  const AuthTextField({
    super.key,
    required this.subText, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subText,
          style: TextStyle(fontSize: 14, color: AppColors.textFieldSubText),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 54,
          width: 348,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    BorderSide(color: AppColors.textFieldStroke, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: AppColors.textFieldStroke, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: AppColors.textFieldStroke, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}