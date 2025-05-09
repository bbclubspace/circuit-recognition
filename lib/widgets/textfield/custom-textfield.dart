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
    required this.width,
    this.issubFixIcon,
    this.subFixIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subText,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.textFieldStroke
                  : AppColors.descriptionTextColor,
            )),
        SizedBox(height: 5),
        SizedBox(
          height: height, //authda 54 olacak
          width: width, //authda 348 olacak
          child: TextField(
            controller: controller,
            minLines: 3, // Başlangıçta 3 satır
            maxLines: null, // Satır sayısı kadar uzasın
            cursorColor: Theme.of(context).brightness == Brightness.light
                ? AppColors.textFieldStroke
                : AppColors.descriptionTextColor,
            decoration: InputDecoration(
              suffixIcon: (issubFixIcon ?? false) && subFixIconPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        subFixIconPath!,
                        width: 24,
                        height: 24,
                      ),
                    )
                  : const SizedBox(),
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFieldStroke
                      : AppColors.descriptionTextColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFieldStroke
                      : AppColors.descriptionTextColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.textFieldStroke
                      : AppColors.descriptionTextColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
