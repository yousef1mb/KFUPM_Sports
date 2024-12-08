import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/event_model.dart';
import 'package:kfupm_sports/models/player_model.dart';

class GeneralProvider extends ChangeNotifier {
  Event event = Event(
    sport: 'TBA',
    player: 'Uknown',
    playersJoined: '0',
    date: 'TBA',
    location: 'TBA',
  );
  Player player = Player(
    name: "Unknown",
    avatar: const Icon(Icons.person),
    bio: "No Bio",
    favoriteSports: [],
    prefferedPositions: [],
  );
}
