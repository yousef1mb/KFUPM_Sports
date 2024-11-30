import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';
import 'package:kfupm_sports/models/event_model.dart';

class EventsPageView extends StatelessWidget {
  const EventsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            AppBar(
              title: Container(
                padding: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Find Match',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              height: 10,
              color: AppColors.navigationBar,
              width: double.infinity,
            ),
          ],
        ),
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
              final sport = event['sport'] as String? ?? 'Unknown';
              final player = event['player'] as String? ?? 'Unknown';
              final location = event['location'] as String? ?? 'Unknown';
              final playersJoined = event['playersJoined'] as String? ?? '0/0';
              final date = event['date'];
              final imageUrl = event['imageUrl'] as String? ?? '';
              EventModel eventObject = EventModel(
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
