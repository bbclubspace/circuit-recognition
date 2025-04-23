// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:circuit_recognition/widgets/button/next-button.dart';
import 'package:circuit_recognition/widgets/onboarding/description-text.dart';
import 'package:circuit_recognition/widgets/onboarding/onboarding-image.dart';
import 'package:circuit_recognition/widgets/text/top-text.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: AppColors.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          // Başlık
          TopText(text: "Uygulamamızı tanıyalım"),
          const SizedBox(height: 50),
          // Açıklama
          DescriptionText(),
          const SizedBox(height: 10),
          // Sayfalar
          OnBoardingImage(),
          const SizedBox(height: 60),
          // Buton
          NextButton(),
        ],
      ),
    );
  }
}








