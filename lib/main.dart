import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          // No user is logged in
          debugPrint('No user logged in.');
          return const LoginScreen();
        }

        final user = snapshot.data!;
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('players')
              .doc(user.uid)
              .get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userSnapshot.hasError) {
              debugPrint(
                  'Error loading Firestore document: ${userSnapshot.error}');
              return const Center(child: Text('Error loading user data.'));
            }

            final data = userSnapshot.data;

            // Check if the document does not exist
            if (data == null || !data.exists) {
              debugPrint('No document found for user: ${user.uid}');
              return const UserInfoFormScreen();
            }

            debugPrint('Profile is complete for user: ${user.uid}');
            return const PagesView();
          },
        );
      },
    );
  }
}
