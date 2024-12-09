import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MatchProvider with ChangeNotifier {
  // Fetch all matches as a list of Map<String, dynamic>
  Stream<List<Map<String, dynamic>>> getAllMatches() {
    return FirebaseFirestore.instance
        .collection("playerMatches")
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  // Stream player's matches as a list of DocumentSnapshot
  Stream<List<DocumentSnapshot>> streamPlayerMatchesWithReferences(
      BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final kfupmId = userProvider.kfupmId;

    if (kfupmId == null) {
      // Return an empty stream if KFUPM ID is not available
      return const Stream.empty();
    }

    // Fetch the matches references for the player and return the actual match documents
    return FirebaseFirestore.instance
        .collection('playerMatches')
        .doc(kfupmId)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.exists) {
        final data = snapshot.data();
        final matchesRefs = data?['matches'] as List<dynamic>? ?? [];

        // Fetch match documents using the references
        final List<DocumentSnapshot> fetchedMatches = [];
        for (var matchRef in matchesRefs) {
          if (matchRef is DocumentReference) {
            final matchDoc = await matchRef.get();
            if (matchDoc.exists) {
              fetchedMatches.add(matchDoc);
            }
          }
        }
        return fetchedMatches;
      } else {
        return [];
      }
    });
  }

  // Example: Add a new match to a player's matches list
  Future<void> addMatchToPlayer(
      BuildContext context, DocumentReference matchRef) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final kfupmId = userProvider.kfupmId;

    if (kfupmId == null) {
      throw Exception("KFUPM ID is not available.");
    }

    final playerMatchesDoc =
        FirebaseFirestore.instance.collection('playerMatches').doc(kfupmId);

    await playerMatchesDoc.update({
      'matches': FieldValue.arrayUnion([matchRef]),
    });
  }

  // Example: Remove a match from a player's matches list
  Future<void> removeMatchFromPlayer(
      BuildContext context, DocumentReference matchRef) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final kfupmId = userProvider.kfupmId;

    if (kfupmId == null) {
      throw Exception("KFUPM ID is not available.");
    }

    final playerMatchesDoc =
        FirebaseFirestore.instance.collection('playerMatches').doc(kfupmId);

    await playerMatchesDoc.update({
      'matches': FieldValue.arrayRemove([matchRef]),
    });
  }
}
