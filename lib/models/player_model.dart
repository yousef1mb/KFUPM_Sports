import 'package:flutter/material.dart';

class Player {
  final String name;
  final Icon avatar;
  final String bio;
  final List<String> favoriteSports;
  final List<String> prefferedPositions;

  Player({
    required this.name,
    required this.avatar,
    required this.bio,
    required this.favoriteSports,
    required this.prefferedPositions,
  });
}
