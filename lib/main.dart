import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kfupm_sports/core/theme/theme.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kfupm_sports/providers/general_provider.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'features/authentication/auth_screen.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the theme provider
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme(); // Load the saved theme

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeProvider),
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: const KFUPMSportsApp(),
    ),
  );
}

class KFUPMSportsApp extends StatelessWidget {
  const KFUPMSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: themeProvider.themeMode,
      home: const AuthWrapper(),
      routes: {
        '/home': (context) => const PagesView(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

/// AuthWrapper checks if the user is logged in
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for authentication state
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          // If the user is logged in, show the main app
          authenticationProvider.user != null; // Ensure user is updated
          return const PagesView();
        }
        // If the user is not logged in, show the login screen
        return LoginScreen();
      },
    );
  }
}
