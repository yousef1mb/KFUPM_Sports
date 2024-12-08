import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchProvider with ChangeNotifier {
  Stream<List<Map<String, dynamic>>> getAllMatches() {
    return FirebaseFirestore.instance
        .collection("playerMatches")
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
  }
}
