import 'package:flutter/material.dart';

import 'themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider({required Brightness brightness})
      : _themeData = brightness == Brightness.dark
            ? AppColors.darkTheme
            : AppColors.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == AppColors.lightTheme) {
      themeData = AppColors.darkTheme;
    } else {
      themeData = AppColors.lightTheme;
    }
  }
}
