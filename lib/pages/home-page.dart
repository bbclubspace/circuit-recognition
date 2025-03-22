// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:circuit_recognition/widgets/content/content.dart';
import 'package:circuit_recognition/widgets/welcomeTextAndUserIcon/userIcon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          //anasayfa texti ve kullanıcı iconu
          WelcomeTextAndUserIcon(),
          const SizedBox(height: 100),
          // projelerim,yeniproje,chatbot
          Content(),
        ],
      ),
    );
  }
}


