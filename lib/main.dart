import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kfupm_sports/core/theme/theme.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kfupm_sports/providers/general_provider.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  //Init Firebase instance
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the theme provider
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();  // Load the saved theme
  
  runApp(ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const KFUPMSportsApp(),
    ),);
}

class KFUPMSportsApp extends StatelessWidget {
  const KFUPMSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return GeneralProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: themeProvider.themeMode,
        home: const PagesView(),
      ),
    );
  }
}
