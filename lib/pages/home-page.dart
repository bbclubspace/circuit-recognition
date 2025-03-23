// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:circuit_recognition/utils/responsive.dart';
import 'package:circuit_recognition/widgets/content/content.dart';
import 'package:circuit_recognition/widgets/welcomeTextAndUserIcon/userIcon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Responsive.responsivePadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.blockSizeVertical(context) * 2),
              //anasayfa texti ve kullanıcı iconu
              const WelcomeTextAndUserIcon(),
              SizedBox(height: Responsive.blockSizeVertical(context) * 5),
              // projelerim,yeniproje,chatbot
              const Expanded(child: Content()),
            ],
          ),
        ),
      ),
    );
  }
}


