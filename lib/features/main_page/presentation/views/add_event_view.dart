import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../../../../providers/general_provider.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  CollectionReference events = FirebaseFirestore.instance.collection("events");
  final List<String> sports = ['football', 'volleyball', 'basketball', 'Tennis'];
  final List<String> locations = ['11', '36', '39'];
  DateTime? selectedDateTime;
  int playersCount = 0;
  int capacity = 18; // Default total capacity
  int remainingCapacity = 18; // Tracks remaining capacity

  @override
  void initState() {
    super.initState();
    final event = Provider.of<GeneralProvider>(context, listen: false).event;
    playersCount = int.tryParse(event.playersJoined) ?? 0;
    remainingCapacity = capacity - playersCount; // Initialize remaining capacity
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<GeneralProvider>(context, listen: false).event;

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
              // Sport Name Dropdown
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

              // Register Guests
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Register a Guest:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (playersCount > 0) {
                          playersCount--;
                          remainingCapacity++; // Increase remaining capacity
                          event.playersJoined = playersCount.toString();
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
                          remainingCapacity--; // Decrease remaining capacity
                          event.playersJoined = playersCount.toString();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Capacity reached!")),
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Remaining Capacity Display
              TextFormField(
                initialValue: remainingCapacity.toString(),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Remaining Capacity",
                ),
              ),
              const SizedBox(height: 16),

              // Location Dropdown
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

              // Date & Time Picker Button
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
                    String timeStr = DateFormat('HH:mm')
                        .format(combinedDateTime);
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
                    event.date.isEmpty ||
                    event.location.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill in all fields")),
                  );
                  return;
                }
                try {
                  const uuid = Uuid();
                  await events.doc(uuid.v4()).set({
                    "sport": event.sport,
                    "player": event.player,
                    "playersJoined": event.playersJoined,
                    "remainingCapacity": remainingCapacity.toString(),
                    "date": event.date,
                    "location": event.location,
                    "imageUrl": event.imageUrl,
                  });

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
