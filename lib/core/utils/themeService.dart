// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'themeKey';

  // Get the current theme
  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    return themeIndex == 0 ? ThemeMode.light : ThemeMode.dark;
  }

  // Save the theme
  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themeKey, themeMode == ThemeMode.light ? 0 : 1);
  }
}
