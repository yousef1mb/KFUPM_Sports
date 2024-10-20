import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';

class AppTheme {
  //Define gradient
  static LinearGradient lightGradiant = const LinearGradient(colors: [
    AppColors.primary,
    AppColors.secondary,
    AppColors.primary
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight
  );

  //light theme
  static ThemeData get lightTheme {
    return ThemeData(
      
      
    );
  }
  //dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      
      
    );
  }

}