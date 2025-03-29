import 'package:circuit_recognition/pages/content/chat-bot.dart';
import 'package:circuit_recognition/pages/content/my-project.dart';
import 'package:circuit_recognition/pages/content/new-project.dart';
import 'package:circuit_recognition/pages/home-page.dart';
import 'package:circuit_recognition/pages/login-page.dart';
import 'package:circuit_recognition/pages/signup-page.dart';
import 'package:flutter/material.dart';
import 'package:circuit_recognition/pages/welcome-page.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/myproject': (context) => const MyProject(),
        '/newproject': (context) => const NewProject(),
        '/chatbot': (context) => const ChatBot(),

      },
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
