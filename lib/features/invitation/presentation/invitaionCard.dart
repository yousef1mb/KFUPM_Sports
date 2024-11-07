import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/app_colors.dart';

class InvitationCard extends StatelessWidget {
  final String name;
  final String sport;
  final String day;
  final String time;
  final int building;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  // Constructor for the InvitationCardWidget
  InvitationCard({
    required this.name,
    required this.time,
    required this.day,
    required this.sport,
    required this.building,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      //margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Profile image and details (name, message)
            CircleAvatar(
              backgroundColor: AppColors.secondary,
              radius: 30,
              child: Text(
                sport,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 8,
                    height: 0.07),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Text(time),
                  Row(
                    children: [
                      Text(
                        day,
                      ),
                      Text(" | "),
                      Text(
                        "Bld# $building",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Accept/Decline buttons on the same row
            IconButton(
              iconSize: MediaQuery.of(context).size.width / 10,
              icon: Icon(Icons.check_circle,
                  color: AppColors.navigationBarHighlight),
              onPressed: onAccept,
            ),
            IconButton(
              iconSize: MediaQuery.of(context).size.width / 10,
              icon: Icon(Icons.cancel, color: AppColors.navigationBar),
              onPressed: onDecline,
            ),
          ],
        ),
      ),
    );
  }
}
