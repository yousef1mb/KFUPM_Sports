import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  CollectionReference events = FirebaseFirestore.instance.collection("events");

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<GeneralProvider>(context, listen: false).event;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              event.sport = value;
            },
            decoration: const InputDecoration(
              label: Text("Sport"),
            ),
          ),
          TextField(
            onChanged: (value) {
              event.player = value;
            },
            decoration: const InputDecoration(
              label: Text("Player"),
            ),
          ),
          TextField(
            onChanged: (value) {
              event.playersJoined = value;
            },
            decoration: const InputDecoration(
              label: Text("Players Joined"),
            ),
          ),
          TextField(
            onChanged: (value) {
              event.date = value;
            },
            decoration: const InputDecoration(
              label: Text("Date"),
            ),
          ),
          TextField(
            onChanged: (value) {
              event.location = value;
            },
            decoration: const InputDecoration(
              label: Text("Location"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Uuid uuid = const Uuid();
              events.doc(uuid.v4()).set(
                {
                  "sport": event.sport,
                  "player": event.player,
                  "playersJoined": event.playersJoined,
                  "date": event.date,
                  "location": event.location,
                  "imageUrl": event.imageUrl,
                },
              );
            },
            child: const Text("Add Event"),
          ),
        ],
      ),
    );
  }
}
