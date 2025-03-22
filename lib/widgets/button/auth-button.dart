import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  const AuthButton({
    super.key,
    required this.buttonText, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 54,
        width: 348,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.authButtonBackgroundColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: AppColors.authButtonText,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}