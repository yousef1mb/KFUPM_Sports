import 'package:flutter/material.dart';
import 'package:kfupm_sports/features/authentication/presentation/auth_screen.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const MainApp());
  // initialize services
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KFUPM Sports',
      theme: AppTheme.lightTheme,
      home:const AuthScreen(),
      
    );
  }
}
