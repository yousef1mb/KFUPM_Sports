// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../../../../providers/general_provider.dart';
import '../../../../providers/player_provider.dart';
import '../../../../providers/user_provider.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  CollectionReference events = FirebaseFirestore.instance.collection("events");
  final List<String> sports = [
    'Football',
    'Volleyball',
    'Basketball',
    'Tennis'
  ];
  final List<String> locations = ['11', '36', '39'];
  List<String> players = []; // List of players
  DateTime? selectedDateTime;
  int playersCount = 0;
  int capacity = 24; // Default total capacity
  int remainingCapacity = 24; // Remaining capacity (calculated dynamically)

  @override
  void initState() {
    super.initState();
    _initializePlayerName();
  }

  Future<void> _initializePlayerName() async {
    try {
      // Get the KFUPM ID from the UserProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final kfupmId = userProvider.kfupmId;

      if (kfupmId == null) {
        throw Exception('KFUPM ID is not initialized.');
      }

      // Reference to the player's document in Firestore
      final playerDoc = await FirebaseFirestore.instance
          .collection('players')
          .doc(kfupmId)
          .get();

      if (playerDoc.exists) {
        final playerName = playerDoc['name'] as String;

        setState(() {
          // Update the event player name
          final event =
              Provider.of<GeneralProvider>(context, listen: false).event;
          event.player = playerName;

          // Add the player to the players list
          players.add(playerName);
          playersCount = players.length;
          remainingCapacity = capacity - playersCount;
        });
      } else {
        throw Exception('Player document does not exist.');
      }
    } catch (e) {
      print('Error fetching player name: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching player name: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<GeneralProvider>(context, listen: false).event;
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2B56F),
        title: const Text(
          "Add Event",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(32),
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Sport Name"),
                items: sports.map((sport) {
                  return DropdownMenuItem<String>(
                    value: sport,
                    child: Text(sport),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    event.sport = value;
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Location"),
                items: locations.map((loc) {
                  return DropdownMenuItem<String>(
                    value: loc,
                    child: Text(loc),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    event.location = value;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: capacity.toString(),
                decoration: const InputDecoration(
                  labelText: "Total Capacity",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    final newCapacity = int.tryParse(value) ?? capacity;
                    remainingCapacity = newCapacity - playersCount;
                    capacity = newCapacity;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Register Guests:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (playersCount > 1) {
                              playersCount--;
                              remainingCapacity++;
                              players.removeLast();
                              event.playersJoined = playersCount;
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        playersCount.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (remainingCapacity > 0) {
                              playersCount++;
                              remainingCapacity--;
                              players.add("guest_$playersCount");
                              event.playersJoined = playersCount;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Capacity reached!")),
                              );
                            }
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Text(
                    "Remaining: $remainingCapacity",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final now = DateTime.now();
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(now.year, now.month, now.day),
                    lastDate: DateTime(now.year + 2),
                  );
                  if (pickedDate == null) return;

                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 12, minute: 0),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );
                  if (pickedTime == null) return;

                  final combinedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  setState(() {
                    selectedDateTime = combinedDateTime;
                    String dateStr = DateFormat('d MMM')
                        .format(combinedDateTime)
                        .toUpperCase();
                    String timeStr =
                        DateFormat('HH:mm').format(combinedDateTime);
                    event.date = "$dateStr $timeStr";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF166518),
                ),
                child: Text(
                  selectedDateTime == null
                      ? "Pick Date/Time"
                      : "Selected: ${event.date}",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () async {
                if (event.sport.isEmpty ||
                    event.location.isEmpty ||
                    event.date.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        event.sport.isEmpty
                            ? "Please select a sport name."
                            : event.location.isEmpty
                                ? "Please select a location."
                                : "Please pick a date/time.",
                      ),
                    ),
                  );
                  return;
                }

                try {
                  const uuid = Uuid();
                  String matchId = uuid.v4();
                  await events.doc(matchId).set({
                    "sportName": event.sport,
                    "playersJoined": event.playersJoined,
                    "players": players,
                    "capacity": capacity.toString(),
                    "remainingCapacity": remainingCapacity,
                    "date": event.date,
                    "location": event.location,
                  });

                  await playerProvider.addMatchToPlayer(matchId);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Event added successfully!")),
                  );

                  Navigator.pop(context);
                  final eventProvider =
                      Provider.of<GeneralProvider>(context, listen: false);
                  eventProvider.resetEvent();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error adding event: $e")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF166518),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Add Event",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
