import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  static final themeLight = ColorScheme(
      brightness: Brightness.light,
      primary: Colors.red.shade600,
      onPrimary: Colors.white,
      secondary: Colors.red.shade600,
      onSecondary: Colors.white,
      error: Colors.redAccent.shade400,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      outline: Colors.grey.shade800);

  static final themeDark = ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(10, 147, 150, 1),
      onPrimary: Colors.white,
      secondary: Color.fromRGBO(10, 147, 150, 1),
      onSecondary: Colors.white,
      error: Colors.redAccent.shade400,
      onError: Colors.white,
      surface: Color.fromRGBO(0, 18, 25, 1),
      onSurface: Colors.white,
      outline: Colors.grey.shade600);

  ColorScheme currentColorScheme = themeLight;
  Icon currentThemeIcon = Icon(Icons.light_mode);
  bool isLightMode = true;

  void toggleTheme() {
    if (isLightMode) {
      currentColorScheme = themeDark;
      currentThemeIcon = Icon(Icons.dark_mode);
      isLightMode = false;
    } else {
      currentColorScheme = themeLight;
      currentThemeIcon = Icon(Icons.light_mode);
      isLightMode = true;
    }
    notifyListeners();
  }
}
