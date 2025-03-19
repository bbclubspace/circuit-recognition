import 'package:circuit_recognition/widgets/welcomeTextAndUserIcon/welcomeText.dart';
import 'package:flutter/material.dart';

class WelcomeTextAndUserIcon extends StatelessWidget {
  const WelcomeTextAndUserIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        //Hoşgeldin, Emre
        WelcomeText(),
        SizedBox(width: 100),
        Image.asset("assets/profile-image.png"),
      ],
    );
  }
}

