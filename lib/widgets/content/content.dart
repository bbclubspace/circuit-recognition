// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:circuit_recognition/themes/themes.dart';
import 'package:circuit_recognition/widgets/content/content-container.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            //first container
            ContentContainer(
              height: 200,
              width: 180,
              backgroundColor: AppColors.firstContainer,
              strokeLeftColor: AppColors.firstStrokeColor,
              strokeLeftWidth: 4,
            ),
            const SizedBox(width: 20),
            //second container
            ContentContainer(
              height: 200,
              width: 180,
              backgroundColor: AppColors.secondContainer,
              strokeRightColor: AppColors.secondStrokeColor,
              strokeRightWidth: 4,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            //third container
            SizedBox(
              width: 10,
            ),
            ContentContainer(
              height: 200,
              width: 380,
              backgroundColor: AppColors.thirdContainer,
              strokeBottomColor: AppColors.thirdStrokeColor,
              strokeBottomWidth: 4,
            ),
          ],
        )
      ],
    );
  }
}
