import 'package:flutter/material.dart';

class OnBoardingText extends StatelessWidget {
  const OnBoardingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Uygulamamızı tanıyalım",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..shader = const LinearGradient(
              colors: [Colors.purple, Colors.blue],
            ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 50.0)),
        ),
      ),
    );
  }
}