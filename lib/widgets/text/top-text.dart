import 'package:flutter/material.dart';

class TopText extends StatelessWidget {
  final String text;
  const TopText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        text,
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