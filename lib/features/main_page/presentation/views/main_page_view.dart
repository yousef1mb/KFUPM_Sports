import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/authentication/auth_screen.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'package:kfupm_sports/providers/auth_provider.dart';
import 'package:kfupm_sports/providers/match_provider.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    final matchProvider = Provider.of<MatchProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.dark_mode_outlined,
          ),
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
        backgroundColor: AppColors.navigationBar,
        title: const Text(
          "My Matches",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: matchProvider.streamPlayerMatchesWithReferences(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text('Please make sure to connect to the Internet'));
          }

          final matches = snapshot.data ?? [];

          if (matches.isEmpty) {
            return const Center(child: Text('No matches found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final matchDoc = matches[index];
              final match = matchDoc.data() as Map<String, dynamic>;

              final sport = match['sportName'] ?? 'Unknown Sport';
              final players = match['players'] as List<dynamic>? ?? [];
              final player = players.isNotEmpty ? players[0] : 'Unknown Player';
              final location = match['location'] ?? 'Unknown Location';
              final playersJoined = match['playersJoined'] ?? '0';
              final date = match['date'] ?? 'Unknown Date';
              final remainingCapacity = match['remainingCapacity'] ?? '0';

              Event eventObject = Event(
                sport: sport,
                player: player,
                playersJoined: playersJoined,
                date: date,
                location: location,
              );

              return Column(
                children: [
                  MatchCard(
                    event: eventObject,
                    eventReference: matchDoc.reference, // Pass the reference
                    screenWidth: MediaQuery.of(context).size.width,
                    joined: true,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
