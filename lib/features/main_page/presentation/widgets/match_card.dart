import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math; // For min()

class MatchCard extends StatefulWidget {
  final Event event;
  final double screenWidth;

  const MatchCard({
    super.key,
    required this.event,
    required this.screenWidth,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  bool joined = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widget.screenWidth;
    final double cardWidth = screenWidth * 0.95;

    double cardHeight;
    if (screenWidth < 600) {
      // If screen width is less than 600, use a taller ratio
      cardHeight = cardWidth * 0.34; // adjust as needed
    } else if(screenWidth <1000){
      // If screen width is 1000 or more, use a shorter ratio
      cardHeight = cardWidth * 0.25; // adjust as needed
    } else {
      // If screen width is 600 or more, use a shorter ratio
      cardHeight = cardWidth * 0.19; // adjust as needed
    }

    // Optionally clamp the height to not exceed 425
    cardHeight = math.min(cardHeight, 425);

    double fontSizeFactor = screenWidth / 465.0;
    if (fontSizeFactor > 1.0) {
      fontSizeFactor = 1.0 + (fontSizeFactor - 1.0) * 0.3;
    }

    const double titleBaseSize = 24;
    const double iconBaseSize = 40;
    const double playerNameBaseSize = 22;
    const double playersJoinedBaseSize = 18;
    const double dateAndLocationBaseSize = 16;
    const double buttonBaseSize = 16;

    double titleFontSize = titleBaseSize * fontSizeFactor;
    double iconSize = iconBaseSize * fontSizeFactor;
    double playerNameFontSize = playerNameBaseSize * fontSizeFactor;
    double playersJoinedFontSize = playersJoinedBaseSize * fontSizeFactor;
    double dateAndLocationFontSize = dateAndLocationBaseSize * fontSizeFactor;
    double buttonFontSize = buttonBaseSize * fontSizeFactor;

    double lineSpacing = 4 * fontSizeFactor;
    double basePadding = 12;
    double dynamicPadding = basePadding + (screenWidth * 0.001);

    double iconSportTop = dynamicPadding;
    double iconSportLeft = dynamicPadding;
    double nameTop = iconSportTop + (titleFontSize * 1.2) + (lineSpacing * 2);
    double nameLeft = dynamicPadding;
    double bottomLeftPadding = dynamicPadding;
    double bottomRightPadding = dynamicPadding + 4;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 4,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: ColorFiltered(
                  colorFilter: widget.event.imageUrl == "assets/images/black.jpg"
                      ? const ColorFilter.mode(Colors.white, BlendMode.clear)
                      : const ColorFilter.mode(Colors.white, BlendMode.color),
                  child: Image.network(
                    widget.event.imageUrl,
                    fit: BoxFit.cover,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
              ),

              // Icon + Sport top-left
              Positioned(
                top: iconSportTop,
                left: iconSportLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      size: iconSize,
                      color: Colors.white,
                    ),
                    SizedBox(width: 16 * fontSizeFactor),
                    Text(
                      widget.event.sport,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Name two lines under icon+sport
              Positioned(
                top: nameTop,
                left: nameLeft,
                child: Text(
                  widget.event.player,
                  style: TextStyle(
                    fontSize: playerNameFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // PlayersJoined, Date & Location bottom-left
              Positioned(
                left: bottomLeftPadding,
                bottom: bottomLeftPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.playersJoined,
                      style: TextStyle(
                        fontSize: playersJoinedFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: lineSpacing),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.event.date,
                          style: TextStyle(
                            fontSize: dateAndLocationFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: lineSpacing),
                        Text(
                          widget.event.location,
                          style: TextStyle(
                            fontSize: dateAndLocationFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Join button bottom-right
              Positioned(
                right: bottomRightPadding,
                bottom: bottomRightPadding,
                child: GestureDetector(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: joined ? Colors.lightGreen : const Color(0xFFE7B86D),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      joined ? "Joined" : "Join",
                      style: TextStyle(
                        color: joined ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: buttonFontSize,
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
