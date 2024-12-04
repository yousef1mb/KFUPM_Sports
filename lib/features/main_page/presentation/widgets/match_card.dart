import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'package:uuid/uuid.dart';

class MatchCard extends StatefulWidget {
  final Event event;

  const MatchCard({
    super.key,
    required this.event,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  bool joined = false;

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
                colorFilter: widget.event.imageUrl == "assets/images/black.jpg"
                    ? const ColorFilter.mode(Colors.white, BlendMode.clear)
                    : const ColorFilter.mode(Colors.white, BlendMode.color),
                child: Image.asset(
                  widget.event.imageUrl,
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
                        Text(widget.event.sport, style: titleTextStyle),
                        const SizedBox(height: 8),
                        Text(widget.event.player, style: subtitleTextStyle),
                        const SizedBox(height: 8),
                        Text(
                          widget.event.playersJoined,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(widget.event.date,
                                    style: subtitleTextStyle),
                                const SizedBox(width: 8),
                                Text(widget.event.location,
                                    style: subtitleTextStyle),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  final firebaseFirestore = FirebaseFirestore
                                      .instance
                                      .collection("user_matches");
                                  Uuid uuid = const Uuid();
                                  joined = !joined;
                                  firebaseFirestore
                                      .doc("event: ${uuid.v4()}")
                                      .set({});
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: joined
                                      ? Colors.lightGreen
                                      : const Color(0xFFE7B86D),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  joined ? "Joined" : "Join",
                                  style: TextStyle(
                                      color:
                                          joined ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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

// Styles
const titleTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
const subtitleTextStyle =
    TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
