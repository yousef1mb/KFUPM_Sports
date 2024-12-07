import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Picture and Name
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
            ),
            const SizedBox(height: 12),
            const Text(
              'Abdulrahman AlNasser',
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
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                Chip(
                  label: const Text("🏸 Badminton"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: AppColors.navigationBar),
                  ),
                  backgroundColor: const Color(0xFFE2B56F),
                ),
                Chip(
                  label: const Text("⚽ Football"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: AppColors.navigationBar),
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
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                Chip(
                  label: const Text("🏀 Center"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: AppColors.navigationBar),
                  ),
                  backgroundColor: const Color(0xFFE2B56F),
                ),
                Chip(
                  label: const Text("R Wing"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: AppColors.navigationBar),
                  ),
                  backgroundColor: const Color(0xFFE2B56F),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
