import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/quickalert.dart';
import '../services/auth/auth_provider.dart';
import '../utils/responsive.dart';
import '../widgets/button/alternatif-login-button.dart';
import '../widgets/button/auth-button.dart';
import '../widgets/mydivider.dart';
import '../widgets/text/auth-text.dart';
import '../widgets/textfield/custom-textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController retryPassWordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    retryPassWordController.dispose();
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  void onTap() async {
    String nameValue = nameController.text;
    String surnameValue = surnameController.text;
    String emailValue = emailController.text;
    String passwordValue = passWordController.text;
    String retryPasswordValue = retryPassWordController.text;

    String? errorMessage;
    QuickAlertType alertType = QuickAlertType.error;

    if (emailValue.isEmpty || passwordValue.isEmpty) {
      errorMessage = 'Lütfen e-posta ve şifre giriniz';
      alertType = QuickAlertType.warning;
    } else if (passwordValue.length < 8) {
      errorMessage = 'Şifre en az 8 karakter olmalıdır!';
    } else if (passwordValue != retryPasswordValue) {
      errorMessage = 'Şifreler eşleşmiyor!';
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

    final authProvider =
        Provider.of<CreateAccountProvider>(context, listen: false);

    await Future.delayed(const Duration(seconds: 1));

    User? user = await authProvider.signUpWithEmail(
      name: nameValue,
      surname: surnameValue,
      email: emailValue,
      password: passwordValue,
    );

    if (user != null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Başarılı',
        text: 'Anasayfaya yönlendiriliyorsunuz',
        showConfirmBtn: false,
      );
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/home",
          (Route<dynamic> route) => false,
        );
      });
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Kayıt Başarısız',
        text: 'Kayıt işlemi sırasında bir hata oluştu!',
      );
    }
  }

  void loginWithGoogle() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Yükleniyor...',
      text: 'Lütfen bekleyin',
      barrierDismissible: false,
    );

    final authProvider =
        Provider.of<CreateAccountProvider>(context, listen: false);
    await authProvider.signInWithGoogle(context);
    Navigator.pop(context);

    final user = authProvider.user;
    if (user != null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Başarılı...',
        text: 'Anasayfaya yönlendiriliyorsunuz',
        showConfirmBtn: false,
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Hata!',
        text: 'Giriş işlemi başarısız!',
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
                "Hesap oluştur",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AuthText(
                text1: "Zaten hesabınız var mı ?",
                text2: 'Giriş yapın',
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
              const SizedBox(height: 15),
              CustomTextField(
                  subText: 'Email',
                  controller: emailController,
                  height: 54,
                  width: 348),
              const SizedBox(height: 8),
              CustomTextField(
                  subText: 'Ad',
                  controller: nameController,
                  height: 54,
                  width: 348),
              const SizedBox(height: 8),
              CustomTextField(
                  subText: 'Soyad',
                  controller: surnameController,
                  height: 54,
                  width: 348),
              const SizedBox(height: 8),
              CustomTextField(
                  subText: 'Şifre',
                  controller: passWordController,
                  height: 54,
                  width: 348),
              const SizedBox(height: 8),
              CustomTextField(
                  subText: 'Şifre onayla',
                  controller: retryPassWordController,
                  height: 54,
                  width: 348),
              const SizedBox(height: 8),
              AuthButton(buttonText: "Giriş yap", onTap: onTap),
              const SizedBox(height: 15),
              MyDivider(),
              const SizedBox(height: 15),
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
