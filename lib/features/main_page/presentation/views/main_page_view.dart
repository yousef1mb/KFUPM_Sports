import 'package:flutter/material.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart'; // Update this path based on your structure

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Matches'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MatchCard(
              sport: 'Football',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
            ),
            SizedBox(height: 16), // Spacing between cards
            MatchCard(
              sport: 'Volleyball',
              player: 'Ahmed Saad',
              date: 'Monday 20 Oct',
              location: 'Building 39',
              playersJoined: '14/16',
            ),
          ],
        ),
      ),
    );
  }
}
