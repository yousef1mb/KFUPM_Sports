import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';

class AppTheme {
  //Define gradient
  static LinearGradient lightGradiant = const LinearGradient(
      colors: [AppColors.primary, AppColors.secondary, AppColors.primary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  //light theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(brightness: Brightness.light, primary: AppColors.primary, onPrimary: AppColors.secondary, secondary: AppColors.navigationBar, onSecondary: AppColors.navigationBarHighlight, error: AppColors.headLineBorderColor, onError: AppColors.headLineBorderColor, surface: AppColors.headLineBorderColor, onSurface: AppColors.darkNavigationBarHighlight),
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primary,
    
    appBarTheme:  const AppBarTheme(
      backgroundColor: AppColors.navigationBar,
      
      titleTextStyle: TextStyle(
        color: AppColors.headLineFontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.headLineFontColor),
    ),
    
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.navigationBar,
      selectedItemColor: AppColors.navigationBarHighlight,
      unselectedItemColor: AppColors.headLineBorderColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.headLineFontColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.headLineFontColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppColors.headLineFontColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.headLineFontColor,
        fontSize: 14,
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
        colorScheme: ColorScheme(brightness: Brightness.dark, primary: AppColors.darkPrimary, onPrimary: AppColors.darkSecondary, secondary: AppColors.darkNavigationBar, onSecondary: AppColors.darkNavigationBarHighlight, error: AppColors.darkFontColor, onError: AppColors.headLineBorderColor, surface: AppColors.headLineBorderColor, onSurface: AppColors.navigationBarHighlight),

    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: Colors.grey,
    appBarTheme: const AppBarTheme(
      color: AppColors.darkSecondary,
      titleTextStyle: TextStyle(
        color: AppColors.darkFontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.darkFontColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkNavigationBar,
      selectedItemColor: AppColors.darkNavigationBarHighlight,
      unselectedItemColor: AppColors.darkBorderColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.darkFontColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.darkFontColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppColors.darkFontColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkFontColor,
        fontSize: 14,
      ),
    ),
  );
}
