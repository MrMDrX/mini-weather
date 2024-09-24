import 'package:flutter/material.dart';
import 'package:mini_weather/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == darkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
