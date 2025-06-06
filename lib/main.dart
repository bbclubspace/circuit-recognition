import 'package:circuit_recognition/pages/chat-page.dart';
import 'package:circuit_recognition/pages/content/my-project.dart';
import 'package:circuit_recognition/pages/content/new-project/add-image.dart';
import 'package:circuit_recognition/pages/content/new-project/project-proposal.dart';
import 'package:circuit_recognition/pages/content/new-project/result.dart';
import 'package:circuit_recognition/pages/content/new-project/save-project.dart';
import 'package:circuit_recognition/pages/home-page.dart';
import 'package:circuit_recognition/pages/login-page.dart';
import 'package:circuit_recognition/pages/settings-page.dart';
import 'package:circuit_recognition/pages/signup-page.dart';
import 'package:circuit_recognition/pages/welcome-page.dart';
import 'package:circuit_recognition/services/ai/ai-chat-services.dart';
import 'package:circuit_recognition/services/ai/ai-services.dart';
import 'package:circuit_recognition/services/ai/project/project-services.dart';
import 'package:circuit_recognition/services/content/content-services.dart';
import 'package:circuit_recognition/themes/theme-provider.dart';
import 'package:circuit_recognition/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'services/auth/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebase is started");
  await dotenv.load(fileName: ".env");
  print("Env ortamı başlatıldı");

  final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
        ChangeNotifierProvider(create: (_) => AiServices()),
        ChangeNotifierProvider(create: (_) => AiChatServices()),
        ChangeNotifierProvider(create: (_) => ContentServices()),
        ChangeNotifierProvider(create: (_) => ProjectServices()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(brightness: brightness)),
      ],
      child: const MainApp(),
    ),
  );
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2), () {
        return FirebaseAuth.instance.currentUser;
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          final user = snapshot.data;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemeProvider>(context).themeData,
            home: user != null ? const HomePage() : const WelcomePage(),
            routes: {
              '/home': (context) => const HomePage(),
              '/settings':(context)=>const SettingsPage(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/myproject': (context) => const MyProject(),
              '/newproject': (context) => const AddImage(),
              '/chatbot': (context) => ChatPage(),
              '/new-project-result': (context) => const Result(),
              '/save-project': (context) => SaveProject(),
              '/project-proposal': (context) => ProjectProposal(),
            },
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          );
        }
      },
    );
  }
}
