import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';
import 'package:kfupm_sports/core/utils/constants.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Adjust height as needed
        child: Column(
          children: [
            AppBar(
              title: Container(
                padding: const EdgeInsets.only(
                    top: 20), // Adjust the top padding as needed
                child: const Text(
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
        child: ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, index) {
            return matches[index];
          },
        ),
      ),
    );
  }
}
