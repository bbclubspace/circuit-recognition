// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:circuit_recognition/themes/themes.dart';
import 'package:circuit_recognition/utils/responsive.dart';
import 'package:circuit_recognition/widgets/container/content-container.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void goMyProject(){
      Navigator.pushNamed( context, '/myproject',);
    }

    void newProject(){
      Navigator.pushNamed( context, '/newproject',);
    }

    void chatBot(){
      Navigator.pushNamed( context, '/chatbot',);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //first container
                ContentContainer(
                  heightPercentage: 23,
                  widthPercentage: 44,
                  backgroundColor: AppColors.firstContainer,
                  strokeLeftColor: AppColors.firstStrokeColor,
                  strokeLeftWidth: 5,
                  isNewProjectContainer: false,
                  image: 'assets/project.png',
                  contentText: 'Projelerim',
                  onTap: goMyProject, isNetworkImage: false,
                ),
                 SizedBox(width: Responsive.blockSizeVertical(context) * 0.9),
                //second container
                ContentContainer(
                  heightPercentage: 23,
                  widthPercentage: 44,
                  backgroundColor: AppColors.secondContainer,
                  strokeRightColor: AppColors.secondStrokeColor,
                  strokeRightWidth: 5,
                  isNewProjectContainer: false,
                  image: 'assets/photo.png',
                  contentText: 'Yeni proje ekle',
                  onTap: newProject, isNetworkImage: false,
                ),
              ],
            ),
            SizedBox(height: Responsive.blockSizeVertical(context) * 1),
            //third container
            ContentContainer(
              heightPercentage: 24,
              widthPercentage: 95,
              backgroundColor: AppColors.thirdContainer,
              strokeBottomColor: AppColors.thirdStrokeColor,
              strokeBottomWidth: 5,
              isNewProjectContainer: false,
              image: 'assets/chatbot.png',
              contentText: 'AI ile sohbet et',
              onTap: chatBot, isNetworkImage: false,
            ),
          ],
        );
      },
    );
  }
}
