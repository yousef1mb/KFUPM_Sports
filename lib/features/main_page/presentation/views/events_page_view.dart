// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/views/add_event_view.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/auth_provider.dart';
import '../../../authentication/auth_screen.dart';

class EventsPageView extends StatelessWidget {
  const EventsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
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
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore.collection('events').snapshots(),
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
              final event = events[index].data() as Map<String, dynamic>;
              final sport = event['sport'];
              final player = event['player'];
              final location = event['location'];
              final playersJoined = event['playersJoined'];
              final date = event['date'];
              final imageUrl = event['imageUrl'];
              Event eventObject = Event(
                  sport: sport,
                  player: player,
                  playersJoined: playersJoined,
                  date: date,
                  location: location,
                  imageUrl: imageUrl);
              return Column(
                children: [
                  MatchCard(
                    event: eventObject,
                    screenWidth: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(height: 16),
                ],
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
