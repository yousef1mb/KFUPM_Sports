import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/match_information.dart';
import 'package:uuid/uuid.dart';

class MatchCard extends StatelessWidget {
  final MatchInformation matchInformation;
  const MatchCard({super.key, required this.matchInformation});

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
                colorFilter: ColorFilter.mode(
                    matchInformation.blendColor, BlendMode.color),
                child: Image.asset(
                  matchInformation.image,
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
                  const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(matchInformation.sport, style: titleTextStyle),
                        const SizedBox(height: 8),
                        Text(matchInformation.player, style: subtitleTextStyle),
                        const SizedBox(height: 8),
                        Text(
                          matchInformation.playersJoined,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(matchInformation.date,
                                    style: subtitleTextStyle),
                                const SizedBox(width: 8),
                                Text(matchInformation.location,
                                    style: subtitleTextStyle),
                              ],
                            ),
                            const JoinButton(),
                          ],
                        ),
                      ],
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

class JoinButton extends StatefulWidget {
  const JoinButton({
    super.key,
    joined,
  });

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  bool joined = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          final firebaseFirestore =
              FirebaseFirestore.instance.collection("user_matches");
          Uuid uuid = const Uuid();
          joined = !joined;
          firebaseFirestore.doc("event: ${uuid.v4()}").set({});
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: joined ? Colors.lightGreen : const Color(0xFFE7B86D),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          joined ? "Joined" : "Join",
          style: TextStyle(
              color: joined ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Styles
const titleTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
const subtitleTextStyle =
    TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
