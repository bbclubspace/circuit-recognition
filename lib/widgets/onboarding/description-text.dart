import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Dilediğin donanım cihazının görselini çekerek datasheetlerine ulaşabilir ve projeler geliştirebilirsin",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 17,
            color: AppColors.secondTextColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}