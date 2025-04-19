import 'package:circuit_recognition/utils/responsive.dart';
import 'package:circuit_recognition/widgets/welcomeTextAndUserIcon/welcomeText.dart';
import 'package:flutter/material.dart';

class WelcomeTextAndUserIcon extends StatelessWidget {
  final String name;
  const WelcomeTextAndUserIcon({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Hoşgeldin, Emre
        WelcomeText(name:  name,),
        Image.asset(
          "assets/profile-image.png",
          width: Responsive.containerWidth(context, 10),
          height: Responsive.containerHeight(context, 10),
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}

