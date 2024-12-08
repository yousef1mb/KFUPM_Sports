import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchProvider with ChangeNotifier {
  Stream<List<Map<String, dynamic>>> getAllMatches() {
    var x = FirebaseFirestore.instance.collection("events").snapshots().map(
        (querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
    print(x);
    return x;
  }
}
