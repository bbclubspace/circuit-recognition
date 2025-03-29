import 'package:circuit_recognition/themes/themes.dart';
import 'package:circuit_recognition/utils/responsive.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hoşgeldin, Emre",
      style: TextStyle(
        color: AppColors.textColor,
        fontSize: Responsive.textSize(context, 7),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}