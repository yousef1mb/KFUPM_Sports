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

  /// Fetch current player/user data from (players collection in firebase)
  Future<void> fetchPlayerMatches() async {
    try {
      final doc = await _firestore.collection('players').doc(userId).get();
      if (doc.exists) {
        _playerData = doc.data()!;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching player data: $e');
      throw Exception('Failed to fetch player data');
    }
  }
}
