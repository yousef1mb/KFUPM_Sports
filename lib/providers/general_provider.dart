import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/event_model.dart';

class GeneralProvider extends ChangeNotifier {
  Event event = Event(
    sport: 'TBA',
    player: 'Uknown',
    playersJoined: '0/22',
    date: 'TBA',
    location: 'TBA',
    imageUrl: 'assets/images/black.jpg',
  );
}
