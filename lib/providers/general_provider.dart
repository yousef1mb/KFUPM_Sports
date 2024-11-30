import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/event_model.dart';

class GeneralProvider extends ChangeNotifier {
  EventModel event = EventModel(
    sport: '',
    player: '',
    playersJoined: '',
    date: '',
    location: '',
    imageUrl: '',
  );
}
