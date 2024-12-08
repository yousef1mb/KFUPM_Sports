import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  final String userId;

  PlayerProvider({required this.userId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Player data model (for demonstration purposes, adjust as needed)
  Map<String, dynamic> _playerData = {};
  Map<String, dynamic> get playerData => _playerData;

  /// Fetch player data from (players collection in firebase)
  Future<void> fetchPlayerData() async {
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

  /// Save or update player data in players collection
  Future<void> savePlayerData(Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('players')
          .doc(userId)
          .set(data, SetOptions(merge: true));
      _playerData = data;
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving player data: $e');
      throw Exception('Failed to save player data');
    }
  }

  /// Add a match to the player's matches array in playerMatches collection
  Future<void> addMatchToPlayer(String matchId) async {
    try {
      await _firestore.collection('playerMatches').doc(userId).update({
        'matches': FieldValue.arrayUnion([matchId]),
      });
      _playerData['matches'] = [...?_playerData['matches'], matchId];
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding match: $e');
      throw Exception('Failed to add match');
    }
  }

  /// Remove a match from the player's matches array in playerMatches collection
  Future<void> removeMatchFromPlayer(String matchId) async {
    try {
      await _firestore.collection('playerMatches').doc(userId).update({
        'matches': FieldValue.arrayRemove([matchId]),
      });
      _playerData['matches'] = (_playerData['matches'] as List)
          .where((id) => id != matchId)
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error removing match: $e');
      throw Exception('Failed to remove match');
    }
  }
}
