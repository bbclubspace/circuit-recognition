import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../../utils/responsive.dart';

class ProjectTextAndImage extends StatelessWidget {
  final String text;
  final String image;
  const ProjectTextAndImage({
    super.key, required this.text, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image,height: 50,width: 50,),
        SizedBox(width: Responsive.blockSizeHorizontal(context) * 5),
        Text(text,style: TextStyle(color: AppColors.textColor,fontWeight: FontWeight.bold),),
      ],
    );
  }
}