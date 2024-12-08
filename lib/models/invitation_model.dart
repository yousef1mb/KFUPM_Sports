import 'package:flutter/material.dart';

class Invitation {
  final String name;
  final String time;
  final String day;
  final int building;
  final String sport;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  Invitation({
    required this.day,
    required this.time,
    required this.building,
    required this.sport,
    required this.name,
    required this.onAccept,
    required this.onDecline,
  });
}
