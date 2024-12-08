import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  final String userId;
  PlayerProvider({required this.userId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Player data model
  Map<String, dynamic> _playerData = {};
  Map<String, dynamic> get playerData => _playerData;

  // Matches data model
  List<Map<String, dynamic>> _matches = [];
  List<Map<String, dynamic>> get matches => _matches;

  /// Fetch current player/user data from players collection in Firestore
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

  /// Save or update current player/user data in players collection
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
      _matches.add({'id': matchId});
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
      _matches = _matches.where((match) => match['id'] != matchId).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error removing match: $e');
      throw Exception('Failed to remove match');
    }
  }
}
