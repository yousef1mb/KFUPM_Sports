import 'package:flutter/material.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/match_card.dart';
import 'package:kfupm_sports/features/main_page/presentation/widgets/bottom_navigation_bar.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Adjust height as needed
        child: Column(
          children: [
            AppBar(
              title: Container(
                padding: EdgeInsets.only(
                    top: 20), // Adjust the top padding as needed
                child: Text(
                  'My Matches',
                  style: TextStyle(
                    fontSize: 32, // Larger font size
                    fontWeight: FontWeight.bold, // Bold font
                    color: Colors.black, // Black color
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent, // Transparent background
              elevation: 0, // No shadow
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 16.0), // Adjust the value as needed
              height: 10, // Height of the line
              color: AppColors.navigationBar, // Color of the line
              width: double.infinity, // Full width
            ),
          ],
        ),
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
