import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../services/auth/auth_provider.dart';
import '../themes/theme-provider.dart';
import '../themes/themes.dart';
import '../widgets/settings/setting-item.dart';
import '../widgets/settings/setting-switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<CreateAccountProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context); // ThemeProvider'ı alıyoruz

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ayarlar",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              SettingSwitch(
                title: "Dark mode",
                icon: Ionicons.moon,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: themeProvider.themeData == AppColors.darkTheme, // Dark mode kontrolü
                onTap: (value) {
                  setState(() {
                    themeProvider.toggleTheme(); // Tema değiştirilir
                  });
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Çıkış yap",
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {
                  authProvider.signOut();
                  Navigator.pushReplacementNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
