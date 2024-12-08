import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_sports/providers/uuid_provider.dart';
import 'package:provider/provider.dart';

class MatchProvider with ChangeNotifier {
  Stream<List<Map<String, dynamic>>> getAllMatches() {
    return FirebaseFirestore.instance
        .collection("playerMatches")
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> streamPlayerMatches(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return FirebaseFirestore.instance
        .collection('playerMatches')
        .doc(userProvider.kfupmId)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.exists) {
        final data = snapshot.data();
        final matchesRefs = data?['matches'] as List<dynamic>? ?? [];

        // Fetch each referenced match's data
        final fetchedMatches = <Map<String, dynamic>>[];
        for (var matchRef in matchesRefs) {
          if (matchRef is DocumentReference) {
            final matchDoc = await matchRef.get();
            if (matchDoc.exists) {
              fetchedMatches.add(matchDoc.data()! as Map<String, dynamic>);
            }
          }
        }

        return fetchedMatches;
      } else {
        return [];
      }
    });
  }
}
