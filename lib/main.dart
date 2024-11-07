import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/utils/background.dart';
import 'package:kfupm_sports/features/authentication/presentation/auth_screen.dart';
import 'package:kfupm_sports/features/invitation/presentation/invitationList.dart';
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
      home: Scaffold(
          body: Background(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [SizedBox(height: 70,),
              InvitationList(),
            ],
          ),
        ),
      )),
    );
  }
}
