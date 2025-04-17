// ignore_for_file: use_super_parameters

import 'package:circuit_recognition/widgets/container/content-container.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../../utils/responsive.dart';
import '../../widgets/myproject/project-text-and-image.dart';
import '../../widgets/text/top-text.dart';

class MyProject extends StatelessWidget {
  const MyProject({Key? key}) : super(key: key);

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
            TopText(text: "Projelerim"),
            SizedBox(height: Responsive.blockSizeVertical(context) * 5),
            ContentContainer(
              heightPercentage: 25,
              widthPercentage: 90,
              backgroundColor: AppColors.firstContainer,
              strokeBottomColor: AppColors.firstStrokeColor,
              strokeBottomWidth: 5,
              isNewProjectContainer: false,
              image: 'assets/hard-work.png',
              contentText: 'Hırsızlara karşı alarm sistemi', isNetworkImage: false,
            ),
            ListView(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(),
              padding: Responsive.responsivePadding(context)*2,
              children: <Widget>[
                Column(
                  children: [
                    ProjectTextAndImage(image: 'assets/working.png',text: "Ses ile cihaz kontrolü",),
                    SizedBox(height: Responsive.blockSizeVertical(context) * 2),
                    ProjectTextAndImage(image: 'assets/working.png',text: "Buzzer ile piyano",),
                    SizedBox(height: Responsive.blockSizeVertical(context) * 2),
                    ProjectTextAndImage(image: 'assets/working.png',text: "Wifi ile oyun kolu",),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


