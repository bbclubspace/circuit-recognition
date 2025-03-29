// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:circuit_recognition/utils/responsive.dart';
import 'package:circuit_recognition/widgets/button/go-next-button.dart';
import 'package:circuit_recognition/widgets/text/top-text.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../../widgets/content/content-container.dart';

class NewProject extends StatelessWidget {
  const NewProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: Responsive.responsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.blockSizeVertical(context) * 10),
            TopText(text: "Malzemeleri Belirleyelim"),
            SizedBox(height: Responsive.blockSizeVertical(context) * 7),
            ContentContainer(
              heightPercentage: 25,
              widthPercentage: 70,
              backgroundColor: AppColors.secondContainer,
              strokeTopColor: AppColors.secondStrokeColor,
              strokeTopWidth: 1.5,
              image: 'assets/photo.png',
              contentText: 'Görsel ekle',
            ),
            SizedBox(height: Responsive.blockSizeVertical(context) * 20),
            GoNextButton()
          ],
        ),
      ),
    );
  }
}
