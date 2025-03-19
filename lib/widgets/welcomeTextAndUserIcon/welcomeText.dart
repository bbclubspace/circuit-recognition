import 'package:circuit_recognition/themes/themes.dart';
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
          fontSize: 30,
          fontWeight: FontWeight.bold),
    );
  }
}