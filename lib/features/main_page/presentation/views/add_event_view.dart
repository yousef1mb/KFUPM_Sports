import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  CollectionReference events = FirebaseFirestore.instance.collection("events");

  // Sports and location options
  final List<String> sports = ['football', 'volleyball', 'basketball', 'padel'];
  final List<String> locations = ['11', '36', '39'];

  // For date & time
  DateTime? selectedDateTime;

  // For players count
  int playersCount = 0;

  @override
  void initState() {
    super.initState();
    final event = Provider.of<GeneralProvider>(context, listen: false).event;
    playersCount = int.tryParse(event.playersJoined) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<GeneralProvider>(context, listen: false).event;

    final double screenWidth = MediaQuery.of(context).size.width;
    double fontSizeFactor = screenWidth / 465.0;
    if (fontSizeFactor > 1.0) {
      fontSizeFactor = 1.0 + (fontSizeFactor - 1.0) * 0.3;
    }

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
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          // Sport Dropdown
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Sport",
            ),
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

          // Players Joined Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Players Joined:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (playersCount > 0) {
                      playersCount--;
                      event.playersJoined = playersCount.toString();
                    }
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                playersCount.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (playersCount < 18) {
                      playersCount++;
                      event.playersJoined = playersCount.toString();
                    }
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Date & Time Picker Button
          ElevatedButton(
            onPressed: () async {
              final now = DateTime.now();
              // Pick Date
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(now.year, now.month, now.day),
                lastDate: DateTime(now.year + 2),
              );
              if (pickedDate == null) return;

              // Pick Time (24-hour format)
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 12, minute: 0),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              );
              if (pickedTime == null) return;

              // Combine date and time
              final combinedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );

              setState(() {
                selectedDateTime = combinedDateTime;
                // Format "18 JUN 13:45"
                String dateStr = DateFormat('d MMM').format(combinedDateTime).toUpperCase();
                String timeStr = DateFormat('HH:mm').format(combinedDateTime);
                event.date = "$dateStr $timeStr";
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE2B56F),
            ),
            child: Text(
              selectedDateTime == null
                  ? "Pick Date/Time"
                  : "Selected: ${event.date}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Location Dropdown
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Location",
            ),
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

          // Image URL
          TextField(
            onChanged: (value) {
              event.imageUrl = value;
            },
            decoration: const InputDecoration(
              labelText: "Sport/Match Image",
            ),
          ),
          const SizedBox(height: 50),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE2B56F)),
            onPressed: () async {
              // Basic validation
              if (event.sport.isEmpty ||
                  event.player.isEmpty ||
                  event.playersJoined.isEmpty ||
                  event.date.isEmpty ||
                  event.location.isEmpty ||
                  event.imageUrl.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill in all fields")),
                );
                return;
              }

              try {
                final uuid = const Uuid();
                await events.doc(uuid.v4()).set(
                  {
                    "sport": event.sport,
                    "player": event.player,
                    "playersJoined": event.playersJoined,
                    "date": event.date,
                    "location": event.location,
                    "imageUrl": event.imageUrl,
                  },
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Event added successfully!")),
                );

                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error adding event: $e")),
                );
              }
            },
            child: const Text(
              "Add Event",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
