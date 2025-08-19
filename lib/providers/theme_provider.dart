import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final SharedPreferences prefs;
  late ColorScheme currentColorScheme;
  late Icon currentThemeIcon;
  late bool isLightMode;

  ThemeProvider({required bool initialIsLight, required this.prefs}) {
    _setTheme(initialIsLight);
  }

  void _setTheme(bool isLight) {
    isLightMode = isLight;
    currentColorScheme = isLight ? themeLight : themeDark;
    currentThemeIcon = isLight ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode);
  }

  void toggleTheme() async {
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

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLightMode', isLightMode);
  }
}
