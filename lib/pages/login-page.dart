// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:circuit_recognition/widgets/button/alternatif-login-button.dart';
import 'package:circuit_recognition/widgets/button/auth-button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../services/auth/auth_provider.dart';
import '../utils/responsive.dart';
import '../widgets/mydivider.dart';
import '../widgets/text/auth-text.dart';
import '../widgets/textfield/custom-textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passWordController = TextEditingController();
    final authProvider =
        Provider.of<CreateAccountProvider>(context, listen: false);

    void onTapLogin() async {
      String emailValue = emailController.text.trim();
      String passwordValue = passWordController.text.trim();

      String? errorMessage;
      QuickAlertType alertType = QuickAlertType.error;

      if (emailValue.isEmpty || passwordValue.isEmpty) {
        errorMessage = 'Lütfen e-posta ve şifre giriniz';
        alertType = QuickAlertType.warning;
      }

      if (errorMessage != null) {
        QuickAlert.show(
          context: context,
          type: alertType,
          title: 'Hata',
          text: errorMessage,
        );
        return;
      }

      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Yükleniyor...',
        text: 'Lütfen bekleyin',
        barrierDismissible: false,
      );

      await Future.delayed(const Duration(seconds: 1));
      User? user =
          await authProvider.signInWithEmail(emailValue, passwordValue);

      Navigator.pop(context);

      if (user != null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Başarılı...',
          text: 'Anasayfaya yönlendiriliyorsunuz',
          showConfirmBtn: false,
        );
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/home",
          (Route<dynamic> route) => false,
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Hata!',
          text: 'Giriş işlemi başarısız!',
        );
      }
    }

    void onTap() {
      Navigator.pushNamed(
        context,
        '/signup',
      );
    }

    void loginWithGoogle() async {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Yükleniyor...',
        text: 'Lütfen bekleyin',
        barrierDismissible: false,
      );

      User? user = await authProvider.signInWithGoogle(context);
      Navigator.pop(context);

      if (user != null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Başarılı...',
          text: 'Anasayfaya yönlendiriliyorsunuz',
          showConfirmBtn: false,
        );
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Hata!',
          text: 'Google ile giriş başarısız oldu!',
        );
      }
    }

    return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.blockSizeVertical(context) * 10),
              //TEXT
              Text(
                "Giriş yap",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
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
              CustomTextField(
                  subText: 'Email',
                  controller: emailController,
                  height: 54,
                  width: 348),
              SizedBox(height: 8),
              CustomTextField(
                subText: 'Şifre',
                controller: passWordController,
                height: 54,
                width: 348,
              ),
              SizedBox(height: 8),

              //BUTTON
              AuthButton(
                buttonText: "Giriş yap",
                onTap: onTapLogin,
              ),
              SizedBox(height: 15),
              Text(
                "Şifremi unuttum",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
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
                onTap: () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.info,
                    title: 'Facebook ile giriş',
                    text: 'Yakın zamanda sizlerle...',
                    showConfirmBtn: false,
                  );
                },
              ),
              SizedBox(height: 15),
              AlternatifLoginButton(
                image: 'assets/google.png',
                logintText: 'Google ile giriş yap',
                onTap: loginWithGoogle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
