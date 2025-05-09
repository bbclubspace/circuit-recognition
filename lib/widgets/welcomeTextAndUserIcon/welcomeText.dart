// welcomeText.dart
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  final String name;
  
  const WelcomeText({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        'Hoş geldin, $name',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
