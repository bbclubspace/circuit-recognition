import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class AuthText extends StatelessWidget {
  final String text1;
  final String text2;
  final Function onTap;
  const AuthText({
    super.key, required this.text1, required this.text2, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text1,style: TextStyle(color: AppColors.secondAuthText,fontSize: 15,fontWeight: FontWeight.w500),),
        SizedBox(width: 5,),
        InkWell(
          onTap: () => onTap(),
          child: Text(text2,style: TextStyle(color: AppColors.thirdAuthText,fontSize: 15,fontWeight: FontWeight.w500),))
      ],
    );
  }
}