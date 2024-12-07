import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'package:kfupm_sports/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class EventsPageView extends StatelessWidget {
  const EventsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          icon: Icon( Icons.dark_mode_outlined,),
          onPressed: () {
            themeProvider.toggleTheme();
           
          },),
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
                  MatchCard(event: eventObject),
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
