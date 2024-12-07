import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'themeKey';
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  get isDarkMode => themeMode;

  // Load the saved theme from SharedPreferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    _themeMode = themeIndex == 0 ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  // Toggle between light and dark theme
  void toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themeKey, _themeMode == ThemeMode.light ? 0 : 1);
    notifyListeners();
  }
}