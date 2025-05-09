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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    super.dispose();
  }
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

    final authProvider = Provider.of<CreateAccountProvider>(context, listen: false);
    await Future.delayed(const Duration(seconds: 1));
    User? user = await authProvider.signInWithEmail(emailValue, passwordValue);

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
        text: 'Giriş işlemi başarısız!',
      );
    }
  }

  void onTap() {
    Navigator.pushNamed(context, '/signup');
  }

  void loginWithGoogle() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Yükleniyor...',
      text: 'Lütfen bekleyin',
      barrierDismissible: false,
    );

    final authProvider = Provider.of<CreateAccountProvider>(context, listen: false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.blockSizeVertical(context) * 10),
              Text(
                "Giriş yap",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AuthText(
                text1: "Hesabın henüz yok mu ?",
                text2: 'Hesap oluştur',
                onTap: onTap,
              ),
              const SizedBox(height: 20),
              CustomTextField(subText: 'Email', controller: emailController, height: 54, width: 348),
              const SizedBox(height: 8),
              CustomTextField(subText: 'Şifre', controller: passWordController, height: 54, width: 348),
              const SizedBox(height: 8),
              AuthButton(buttonText: "Giriş yap", onTap: onTapLogin),
              const SizedBox(height: 15),
             /*  Text(
                "Şifremi unuttum",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              */
              const SizedBox(height: 20),
              MyDivider(),
              const SizedBox(height: 20),
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
              const SizedBox(height: 15),
              AlternatifLoginButton(
                image: 'assets/google.png',
                logintText: 'Google ile giriş yap',
                onTap: loginWithGoogle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
