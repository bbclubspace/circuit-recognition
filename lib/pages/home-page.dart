// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:circuit_recognition/themes/themes.dart';
import 'package:circuit_recognition/utils/responsive.dart';
import 'package:circuit_recognition/widgets/content/content.dart';
import 'package:circuit_recognition/widgets/welcomeTextAndUserIcon/userIcon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String userName = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final provider = Provider.of<CreateAccountProvider>(context, listen: false);
    await provider.loadUserData();
    final data = provider.userData;
    if (data != null && mounted) {
      setState(() {
        userName = data['name'] ?? '';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: Responsive.responsivePadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.blockSizeVertical(context) * 2),
              //anasayfa texti ve kullanıcı iconu
              WelcomeTextAndUserIcon(name: userName,),
              SizedBox(height: Responsive.blockSizeVertical(context) * 3),
              // projelerim,yeniproje,chatbot
              const Expanded(child: Content()),
            ],
          ),
        ),
      ),
    );
  }
}


