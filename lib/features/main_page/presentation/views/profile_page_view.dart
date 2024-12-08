// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/authentication/auth_screen.dart';
import 'package:kfupm_sports/providers/auth_provider.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    //providers
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    return Scaffold(
      //appBar should be refactored
      appBar: AppBar(
        backgroundColor: AppColors.navigationBar,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.dark_mode_outlined),
          onPressed: () {
            themeProvider.toggleTheme();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              // Logout logic
              await authProvider.logout();

              // Show Snackbar to confirm logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You have been logged out')),
              );

              // Navigate back to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: firebaseFirestore.collection("players").get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.green));
              }

              if (snapshot.hasError) {
                return const Center(
                    child: Text('Please make sure to connect to the Internet'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No events found'));
              }

              return ListView(
                children: [
                  // Profile Picture and Name
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Saud",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Line above Bio
                  const Divider(),

                  // Bio Section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bio",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Hi, this is Abdulrahman. I play Volleyball 🏐 since I was five 👶. National Athlete 💪. Hit me up if you would like to play a worthy opponent 🔥.",
                    textAlign: TextAlign.center,
                  ),

                  // Line below Bio description
                  const Divider(),

                  const SizedBox(height: 16),

                  // Favorite Sports Section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Favorite Sports",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: const Text("🏐 Volleyball"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: AppColors.navigationBar), // Border only
                        ),
                        backgroundColor: const Color(0xFFE2B56F),
                      ),
                      Chip(
                        label: const Text(
                          "🏀 Basketball",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                      Chip(
                        label: const Text("🏸 Badminton"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: AppColors.navigationBar),
                        ),
                        backgroundColor: const Color(0xFFE2B56F),
                      ),
                      Chip(
                        label: const Text("⚽ Football"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: AppColors.navigationBar),
                        ),
                        backgroundColor: const Color(0xFFE2B56F),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Preferred Positions Section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Preferred Positions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: const Text(
                          "🏐 Middle Blocker",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                      Chip(
                        label: const Text("🏀 Center"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: AppColors.navigationBar),
                        ),
                        backgroundColor: const Color(0xFFE2B56F),
                      ),
                      Chip(
                        label: const Text("R Wing"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: AppColors.navigationBar),
                        ),
                        backgroundColor: const Color(0xFFE2B56F),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
