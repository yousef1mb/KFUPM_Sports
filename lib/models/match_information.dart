import 'package:flutter/material.dart';

class MatchInformation {
  final String sport;
  final String player;
  final String date;
  final String location;
  final String playersJoined;
  final String image;
  final Color blendColor;

  const MatchInformation({
    required this.sport,
    required this.player,
    required this.date,
    required this.location,
    required this.playersJoined,
    required this.image,
    required this.blendColor,
  });
}
