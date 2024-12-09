// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import "package:kfupm_sports/models/invitation_model.dart";
import '../widgets/invitaion_card.dart';

class InvitationList extends StatelessWidget {
  //List<Invitation> invitations;
  //InvitationList({this.invitations});
  final List<Invitation> invitations = [
    Invitation(
      name: 'Yousef Anwar',
      time: "10:00 AM",
      building: 11,
      day: "Monday 20/10",
      sport: "🏐",
      onAccept: () {
        print('Accepted  invitation');
      },
      onDecline: () {
        print('Declined  invitation');
      },
    ),
    Invitation(
      name: 'Yousef Anwar',
      time: "10:00 AM",
      building: 11,
      day: "Monday 20/10",
      sport: "🏀",
      onAccept: () {
        print('Accepted  invitation');
      },
      onDecline: () {
        print('Declined  invitation');
      },
    ),
    Invitation(
      name: 'Yousef Anwar',
      time: "10:00 AM",
      building: 11,
      day: "Monday 20/10",
      sport: "🏸",
      onAccept: () {
        print('Accepted  invitation');
      },
      onDecline: () {
        print('Declined  invitation');
      },
    ),
    Invitation(
      name: 'Yousef Anwar',
      building: 11,
      day: "Monday 20/10",
      time: "10:00 AM",
      sport: "⚽️",
      onAccept: () {
        print('Accepted  invitation');
      },
      onDecline: () {
        print('Declined  invitation');
      },
    ),
  ];

  InvitationList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap everything inside a SingleChildScrollView
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with invitations count
          Row(
            children: [
              const Text(
                'Invitations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '(${invitations.length})',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Scrollable list of invitations
          SizedBox(
            height: MediaQuery.of(context).size.height /
                2, //  dynamic height calculation
            child: ListView.builder(
              itemCount: invitations.length,
              itemBuilder: (context, index) {
                final invitation = invitations[index];
                return InvitationCard(
                  name: invitation.name,
                  building: invitation.building,
                  time: invitation.time,
                  day: invitation.day,
                  sport: invitation.sport,
                  onAccept: invitation.onAccept,
                  onDecline: invitation.onDecline,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
