// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:circuit_recognition/themes/themes.dart';
import 'package:circuit_recognition/utils/responsive.dart';
import 'package:circuit_recognition/widgets/content/content-container.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //first container
                ContentContainer(
                  heightPercentage: 25,
                  widthPercentage: 45,
                  backgroundColor: AppColors.firstContainer,
                  strokeLeftColor: AppColors.firstStrokeColor,
                  strokeLeftWidth: 5,
                  image: 'assets/project.png',
                  contentText: 'Projelerim',
                ),
                //second container
                ContentContainer(
                  heightPercentage: 25,
                  widthPercentage: 45,
                  backgroundColor: AppColors.secondContainer,
                  strokeRightColor: AppColors.secondStrokeColor,
                  strokeRightWidth: 5,
                  image: 'assets/photo.png',
                  contentText: 'Yeni proje ekle',
                ),
              ],
            ),
            SizedBox(height: Responsive.blockSizeVertical(context) * 1),
            //third container
            ContentContainer(
              heightPercentage: 25,
              widthPercentage: 95,
              backgroundColor: AppColors.thirdContainer,
              strokeBottomColor: AppColors.thirdStrokeColor,
              strokeBottomWidth: 5,
              image: 'assets/chatbot.png',
              contentText: 'AI ile sohbet et',
            ),
          ],
        );
      },
    );
  }
}
