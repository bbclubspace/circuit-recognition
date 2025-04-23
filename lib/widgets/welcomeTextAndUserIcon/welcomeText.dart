import 'package:circuit_recognition/utils/responsive.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  final String name;
  const WelcomeText({
    super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hoşgeldin, $name",
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: Responsive.textSize(context, 7),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}