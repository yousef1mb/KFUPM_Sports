import 'package:flutter/material.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart'; // Update this path based on your structure
import 'package:kfupm_sports/features/main_page/presentation/widgets/bottom_navigation_bar.dart'; // Update this path based on your structure

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  int _currentIndex = 1; // Assuming 'Home' is at index 1

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to different pages based on index
    switch (index) {
      case 0:
        // Navigate to Events page
        break;
      case 1:
        // Stay on Home page
        break;
      case 2:
        // Navigate to Profile page
        break;
    }
  }

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
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
