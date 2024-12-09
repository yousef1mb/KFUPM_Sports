import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kfupm_sports/core/theme/theme.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kfupm_sports/providers/general_provider.dart';
import 'package:kfupm_sports/providers/match_provider.dart';
import 'package:kfupm_sports/providers/player_provider.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:kfupm_sports/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'features/authentication/auth_screen.dart';
import 'features/authentication/user_info_form_screen.dart';
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
        ChangeNotifierProvider(create: (_) => MatchProvider()),
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // Add UserProvider
        ChangeNotifierProxyProvider<UserProvider, PlayerProvider>(
          create: (_) => PlayerProvider(userId: "placeholder"),
          update: (context, userProvider, previous) {
            return PlayerProvider(
                userId: userProvider.kfupmId ?? "placeholder");
          },
        ), // Update PlayerProvider dynamically
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
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loading indicator while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // User is not logged in
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // User is logged in, proceed to initialize user data
        return FutureBuilder<void>(
          future: userProvider.initializeKfupmId(),
          builder: (context, initSnapshot) {
            if (initSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (initSnapshot.hasError) {
              return const Center(
                  child: Text('Failed to initialize user data.'));
            }

            // User data initialized, proceed with profile checks
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('players')
                  .doc(userProvider.kfupmId)
                  .get(),
              builder: (context, profileSnapshot) {
                if (profileSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (profileSnapshot.hasError) {
                  return const Center(
                      child: Text('Failed to load user profile.'));
                }

                final data = profileSnapshot.data;

                // If user profile does not exist, redirect to UserInfoFormScreen
                if (data == null || !data.exists) {
                  return const UserInfoFormScreen();
                }

                // If everything is fine, proceed to main app
                return const PagesView();
              },
            );
          },
        );
      },
    );
  }
}
