import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String? _kfupmId;

  // Getter for KFUPM ID
  String? get kfupmId => _kfupmId;

  // Set or Fetch KFUPM ID using UID
  Future<void> initializeKfupmId() async {
    try {
      // Get the current user from FirebaseAuth
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('No user is logged in.');
      }

      final uid = user.uid; // User's UID
      final email = user.email; // User's email
      if (email == null) {
        throw Exception('User email is null.');
      }

      // Reference to the KFUPM_ID document
      final docRef = FirebaseFirestore.instance.collection('KFUPM_ID').doc(uid);

      // Check if the document exists
      final doc = await docRef.get();

      if (doc.exists) {
        // If the document exists, fetch the KFUPM ID
        _kfupmId = doc['kfupm_id'] as String;
        print('User exists. KFUPM ID fetched: $_kfupmId');
      } else {
        // If the document does not exist, create it
        final extractedKfupmId = email.split('@').first;
        await docRef.set({
          'kfupm_id': extractedKfupmId,
        });

        _kfupmId = extractedKfupmId;
        print('New user created with KFUPM ID: $_kfupmId');
      }

      // Notify listeners to update UI if necessary
      notifyListeners();
    } catch (e) {
      print('Error initializing KFUPM ID: $e');
      throw e; // Re-throw the error for further handling if needed
    }
  }

  // (Optional) Clear KFUPM ID
  void clearKfupmId() {
    _kfupmId = null;
    notifyListeners();
  }
}
