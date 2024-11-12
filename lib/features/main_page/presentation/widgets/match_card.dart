import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String sport;
  final String player;
  final String date;
  final String location;
  final String playersJoined;

  const MatchCard({
    Key? key,
    required this.sport,
    required this.player,
    required this.date,
    required this.location,
    required this.playersJoined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileIcon(),
                const SizedBox(width: 16),
                Expanded(
                  child: MatchDetails(
                    sport: sport,
                    player: player,
                    date: date,
                    location: location,
                    playersJoined: playersJoined,
                  ),
                ),
              ],
            ),
            const Positioned(
              right: 8,
              top: 8,
              child: CardMenu(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: 40,
      color: Colors.grey[700],
    );
  }
}

class MatchDetails extends StatelessWidget {
  final String sport;
  final String player;
  final String date;
  final String location;
  final String playersJoined;

  const MatchDetails({
    Key? key,
    required this.sport,
    required this.player,
    required this.date,
    required this.location,
    required this.playersJoined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sport, style: titleTextStyle),
        const SizedBox(height: 8),
        Text(player, style: subtitleTextStyle),
        const SizedBox(height: 8),
        Text(playersJoined, style: subtitleTextStyle),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(date, style: subtitleTextStyle),
                const SizedBox(width: 8),
                Text(location, style: subtitleTextStyle),
              ],
            ),
            const JoinedButton(),
          ],
        ),
      ],
    );
  }
}

class JoinedButton extends StatelessWidget {
  const JoinedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        'Joined',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        // Handle menu item selection
        print(value);
      },
      itemBuilder: (BuildContext context) {
        return {'Edit', 'Delete', 'Share'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}

// Styles
const titleTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
final subtitleTextStyle = TextStyle(fontSize: 16, color: Colors.grey[700]);
