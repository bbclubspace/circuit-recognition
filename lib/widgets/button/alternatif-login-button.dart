import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';

class AlternatifLoginButton extends StatelessWidget {
  final String image;
  final String logintText;
  final VoidCallback? onTap;
  const AlternatifLoginButton({
    super.key, required this.image, required this.logintText,required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        height: 54,
        width: 348,
        decoration: BoxDecoration(
          color: AppColors.alternatifLoginBackground,
          border: Border.all(
            color: AppColors.alternatifLogin,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(width: 60),
            Image.asset(image),
            SizedBox(width: 20),
            Text(logintText,style: TextStyle(color: AppColors.alternatifLogin,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}