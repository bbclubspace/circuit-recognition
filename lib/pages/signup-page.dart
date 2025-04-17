// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth/auth_provider.dart';
import '../themes/themes.dart';
import '../widgets/button/alternatif-login-button.dart';
import '../widgets/button/auth-button.dart';
import '../widgets/mydivider.dart';
import '../widgets/text/auth-text.dart';
import '../widgets/textfield/custom-textfield.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passWordController = TextEditingController();
    TextEditingController retryPassWordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();

    void onTap() async {
      String nameValue = nameController.text;
      String surnameValue = surnameController.text;
      String emailValue = emailController.text;
      String passwordValue = passWordController.text;
      String retryPasswordValue = retryPassWordController.text;

      if (passwordValue != retryPasswordValue && passwordValue.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Şifreler eşleşmiyor veya şifre 8 karakterden kısa!')),
        );
        return;
      }

      final authProvider =
          Provider.of<CreateAccountProvider>(context, listen: false);
      User? user = await authProvider.signUpWithEmail(
        name: nameValue,
        surname: surnameValue,
        email: emailValue,
        password: passwordValue,
      );

      if (user != null) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Kayıt olma işlemi başarıyla tamamlandı!')),
  );

  Future.delayed(Duration(seconds: 2), () {
    Navigator.pushNamed(context, "/login");
  });
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Kayıt işlemi başarısız!')),
  );
}

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
              CustomTextField(
                subText: 'Email',
                controller: emailController,
                height: 54,width: 348
              ),
              const SizedBox(height: 8),
              CustomTextField(
                subText: 'Ad',
                controller: nameController,
                height: 54,width: 348
              ),
              const SizedBox(height: 8),
              CustomTextField(
                subText: 'Soyad',
                controller: surnameController,
                height: 54,width: 348
              ),
              const SizedBox(height: 8),
              CustomTextField(
                subText: 'Şifre',
                controller: passWordController,
                height: 54,width: 348
              ),
              const SizedBox(height: 8),
              CustomTextField(
                subText: 'Şifre onayla',
                controller: retryPassWordController,
                height: 54,width: 348
              ),
              const SizedBox(height: 8),

              //BUTTON
              AuthButton(
                buttonText: "Giriş yap",
                onTap: onTap,
              ),
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
