import 'package:flutter/material.dart';
import 'package:kfupm_sports/models/event_model.dart';

class GeneralProvider extends ChangeNotifier {
  Event event = Event(
    sport: '',
    player: 'Uknown',
    playersJoined: 1,
    date: '',
    location: '',
  );

  void resetEvent() {
    event.sport = '';
    event.player = 'Uknown';
    event.playersJoined = 1;
    event.date = '';
    event.location = '';
    notifyListeners();
  }
}
