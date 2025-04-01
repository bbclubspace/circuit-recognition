import 'package:circuit_recognition/pages/content/chat-bot.dart';
import 'package:circuit_recognition/pages/content/my-project.dart';
import 'package:circuit_recognition/pages/content/new-project/new-project.dart';
import 'package:circuit_recognition/pages/content/new-project/result.dart';
import 'package:circuit_recognition/pages/home-page.dart';
import 'package:circuit_recognition/pages/login-page.dart';
import 'package:circuit_recognition/pages/signup-page.dart';
import 'package:circuit_recognition/pages/welcome-page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'services/auth/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase'i başlatmadan önce bunu eklemelisin
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebase is started");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
      ],
      child: MainApp(),
    ),
  );
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
        '/new-project-result': (context) => const Result(),
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
