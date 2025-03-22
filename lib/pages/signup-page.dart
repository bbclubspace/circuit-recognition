// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:circuit_recognition/pages/login-page.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';
import '../widgets/button/alternatif-login-button.dart';
import '../widgets/button/auth-button.dart';
import '../widgets/mydivider.dart';
import '../widgets/text/auth-text.dart';
import '../widgets/textfield/auth-textfield.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
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
              const SizedBox(height: 120),
              //TEXT
              Text(
                "Hesap oluştur",
                style: TextStyle(
                    color: AppColors.firstAuthText,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              AuthText(
                text1: "Zaten hesabınız var mı ?",
                text2: 'Giriş yapın',
                onTap: onTap,
              ),
              const SizedBox(height: 15),
              //TEXTFIELD
              AuthTextField(subText: 'Email'),
              const SizedBox(height: 8),
              AuthTextField(subText: 'Ad'),
              const SizedBox(height: 8),
              AuthTextField(subText: 'Soyad'),
              const SizedBox(height: 8),
              AuthTextField(subText: 'Şifre'),
              const SizedBox(height: 8),
              AuthTextField(subText: 'Şifre onayla'),
              const SizedBox(height: 8),

              //BUTTON
              AuthButton(buttonText: "Giriş yap", onTap: onTap,),
              const SizedBox(height: 15),
              MyDivider(),

              //GOOGLE AND FACEBOOK
              const SizedBox(height: 15),
              AlternatifLoginButton(
                image: 'assets/facebook.png',
                logintText: 'Facebook ile giriş yap',
              ),
              const SizedBox(height: 15),
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
