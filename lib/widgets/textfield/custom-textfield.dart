import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String subText;
  final double height;
  final double width;
  final bool? issubFixIcon;
  final String? subFixIconPath;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.subText,
    required this.controller,
    required this.height,
    required this.width,  this.issubFixIcon,  this.subFixIconPath,
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
          height: height, //authta 54 olacak
          width: width, //authta 348 olacak
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                 suffixIcon: (issubFixIcon ?? false) && subFixIconPath != null
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            subFixIconPath!, // null olmayacağını garanti ettiğimiz için ! kullanıyoruz
            width: 24,
            height: 24,
          ),
        )
      : const SizedBox(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: height / 4, horizontal: 12),
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
