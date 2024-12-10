// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/add_event_view.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:kfupm_sports/providers/auth_provider.dart';
import 'package:kfupm_sports/providers/user_provider.dart';
import 'package:kfupm_sports/features/authentication/auth_screen.dart';

class EventsPageView extends StatelessWidget {
  const EventsPageView({super.key});

  Future<String?> _fetchCurrentUserName(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final kfupmId = userProvider.kfupmId;

      if (kfupmId == null) {
        throw Exception('KFUPM ID is not initialized.');
      }

      // Reference to the player's document in Firestore
      final playerDoc = await FirebaseFirestore.instance
          .collection('players')
          .doc(kfupmId)
          .get();

      if (playerDoc.exists) {
        return playerDoc['name'] as String?;
      } else {
        throw Exception('Player document does not exist.');
      }
    } catch (e) {
      debugPrint('Error fetching current user name: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

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
          "Matches",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<String?>(
        future: _fetchCurrentUserName(context),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }

          if (userSnapshot.hasError || userSnapshot.data == null) {
            return const Center(
                child: Text('Error fetching current user name.'));
          }

          final currentUserName = userSnapshot.data!;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('events').snapshots(),
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

              final events = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final eventDoc = events[index];
                  final event = eventDoc.data() as Map<String, dynamic>;

                  // Extract event details
                  final sport = event['sportName'];
                  final players = List<String>.from(event['players']);
                  final location = event['location'];
                  final playersJoined = event['playersJoined'];
                  final date = event['date'];

                  // Determine if the current user has joined the event
                  final isJoined = players.contains(currentUserName);

                  // Create Event model
                  Event eventObject = Event(
                    sport: sport,
                    player: players.isNotEmpty ? players.first : '',
                    playersJoined: playersJoined,
                    date: date,
                    location: location,
                  );

                  return Column(
                    children: [
                      MatchCard(
                        event: eventObject,
                        eventReference: eventDoc.reference, // Pass the reference
                        screenWidth: MediaQuery.of(context).size.width,
                        joined: isJoined, // Set joined based on player list
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddEventView();
              },
            ),
          );
        },
      ),
    );
  }
}
