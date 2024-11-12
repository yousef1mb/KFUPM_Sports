import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String sport;
  final String player;
  final String date;
  final String location;
  final String playersJoined;
  final String imageUrl;
  final Color blendColor;

  const MatchCard({
    super.key,
    required this.sport,
    required this.player,
    required this.date,
    required this.location,
    required this.playersJoined,
    required this.imageUrl,
    required this.blendColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.22,
      width: double.infinity,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        elevation: 4,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(blendColor, BlendMode.color),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.person,
      size: 40,
      color: Colors.white,
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
    super.key,
    required this.sport,
    required this.player,
    required this.date,
    required this.location,
    required this.playersJoined,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sport, style: titleTextStyle),
        const SizedBox(height: 8),
        Text(player, style: subtitleTextStyle),
        const SizedBox(height: 8),
        Text(
          playersJoined,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
            const JoinButton(),
          ],
        ),
      ],
    );
  }
}

class JoinButton extends StatelessWidget {
  const JoinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE7B86D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "Join",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Styles
const titleTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
const subtitleTextStyle =
    TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
