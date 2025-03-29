// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:circuit_recognition/themes/themes.dart';
import 'package:circuit_recognition/widgets/button/alternatif-login-button.dart';
import 'package:circuit_recognition/widgets/button/auth-button.dart';
import 'package:flutter/material.dart';

import '../widgets/mydivider.dart';
import '../widgets/text/auth-text.dart';
import '../widgets/textfield/auth-textfield.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.pushNamed( context, '/signup',);
    }

    void goHome() {
      Navigator.pushNamed( context, '/home',);
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 125),
              //TEXT
              Text(
                "Giriş yap",
                style: TextStyle(
                    color: AppColors.firstAuthText,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              AuthText(
                text1: "Hesabın henüz yok mu ?",
                text2: 'Hesap oluştur',
                onTap: onTap,
              ),
              SizedBox(height: 20),
              //TEXTFIELD
              AuthTextField(subText: 'Email'),
              SizedBox(height: 8),
              AuthTextField(subText: 'Şifre'),
              SizedBox(height: 8),

              //BUTTON
              AuthButton(
                buttonText: "Giriş yap",
                onTap: goHome,
              ),
              SizedBox(height: 15),
              Text(
                "Şifremi unuttum",
                style: TextStyle(
                    color: AppColors.secondAuthText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              MyDivider(),

              //GOOGLE AND FACEBOOK
              SizedBox(height: 20),
              AlternatifLoginButton(
                image: 'assets/facebook.png',
                logintText: 'Facebook ile giriş yap',
              ),
              SizedBox(height: 15),
              AlternatifLoginButton(
                image: 'assets/google.png',
                logintText: 'Google ile giriş yap',
              )
            ],
          ),
        ),
      ),
    );
  }
}
