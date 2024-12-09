// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:kfupm_sports/providers/user_provider.dart';

class MatchCard extends StatefulWidget {
  final Event event;
  final DocumentReference eventReference; // Add event reference
  final double screenWidth;
  final bool joined;

  const MatchCard({
    super.key,
    required this.event,
    required this.eventReference, // Accept event reference
    required this.screenWidth,
    this.joined = false,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late bool joined;
  var playerMatches = FirebaseFirestore.instance.collection("playerMatches");
  @override
  void initState() {
    super.initState();
    joined = widget.joined;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widget.screenWidth;
    final double cardWidth = screenWidth * 0.95;

    double cardHeight;
    if (screenWidth < 600) {
      cardHeight = cardWidth * 0.34;
    } else if (screenWidth < 1000) {
      cardHeight = cardWidth * 0.25;
    } else {
      cardHeight = cardWidth * 0.19;
    }

    cardHeight = math.min(cardHeight, 425);

    // Determine the image path based on the sport
    String getImagePath(String sport) {
      switch (sport.toLowerCase()) {
        case 'football':
          return 'assets/images/football.jpeg';
        case 'volleyball':
          return 'assets/images/volleyball.jpeg';
        case 'basketball':
          return 'assets/images/basketball.jpg';
        case 'tennis':
          return 'assets/images/tennis.jpg';
        default:
          return 'assets/images/black.jpg';
      }
    }

    final String backgroundImage = getImagePath(widget.event.sport);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 4,
          child: Stack(
            children: [
              // Background Image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  width: cardWidth,
                  height: cardHeight,
                ),
              ),

              // Sport Name and Icon
              Positioned(
                top: 12,
                left: 12,
                child: Row(
                  children: [
                    const Icon(
                      Icons.sports,
                      size: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.event.sport,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Player Name
              Positioned(
                top: 48,
                left: 12,
                child: Text(
                  widget.event.player,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Players Joined, Date, and Location
              Positioned(
                left: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Players: ${widget.event.playersJoined}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          widget.event.date,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.event.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Join Button
              Positioned(
                right: 12,
                bottom: 12,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      setState(() {
                        joined = !joined;
                      });

                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      final kfupmId = userProvider.kfupmId;

                      if (kfupmId == null) {
                        throw Exception("KFUPM ID is not available.");
                      }

                      final playerMatchRef = FirebaseFirestore.instance
                          .collection('playerMatches')
                          .doc(kfupmId);

                      if (joined) {
                        // Add the event reference to the matches array
                        await playerMatchRef.update({
                          "matches":
                              FieldValue.arrayUnion([widget.eventReference]),
                        });

                        await widget.eventReference
                            .update({"playersJoined": FieldValue.increment(1)});
                        await widget.eventReference.update(
                            {"remainingCapacity": FieldValue.increment(-1)});
                      } else {
                        // Safely remove the reference
                        await playerMatchRef.update({
                          "matches":
                              FieldValue.arrayRemove([widget.eventReference]),
                        });
                        await widget.eventReference.update(
                            {"playersJoined": FieldValue.increment(-1)});
                        await widget.eventReference.update(
                            {"remainingCapacity": FieldValue.increment(1)});
                      }
                      // Check playersJoined value and delete the document if 0
                      final snapshot = await widget.eventReference.get();
                      final playersJoined = snapshot.get("playersJoined") ?? 0;
                      if (playersJoined == 0) {
                        await widget.eventReference.delete();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Match deleted as no players joined!")),
                          );
                        }
                      }
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(joined
                                ? "Successfully joined!"
                                : "Successfully left!"),
                          ),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          joined ? Colors.lightGreen : const Color(0xFFE7B86D),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      joined ? "Joined" : "Join",
                      style: TextStyle(
                        color: joined ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
