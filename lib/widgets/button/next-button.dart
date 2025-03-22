import 'package:circuit_recognition/pages/login-page.dart';
import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            border: Border(
              // Sağ kenarlık var
              bottom: BorderSide(
                  color: AppColors.buttonPurple, width: 3), // Alt kenarlık var
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}
