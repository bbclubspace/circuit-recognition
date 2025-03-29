import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class GoNextButton extends StatelessWidget {
  const GoNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        width: 150,
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
        child: Center(child: const Text("Devam et",style: TextStyle(color: AppColors.authButtonText,fontWeight: FontWeight.bold,fontSize: 15),))
      ),
    );
  }
}