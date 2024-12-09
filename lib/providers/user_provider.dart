import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String? _kfupmId;
  String? get kfupmId => _kfupmId;

  Future<void> initializeKfupmId() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('No user logged in.');
      }

      final uid = user.uid;
      final email = user.email;

      if (email == null) {
        throw Exception('User email is null.');
      }

      final docRef = FirebaseFirestore.instance.collection('KFUPM_ID').doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        _kfupmId = docSnapshot['kfupm_id'] as String;
      } else {
        _kfupmId = email.split('@').first;
        await docRef.set({'kfupm_id': _kfupmId});
      }

      notifyListeners();
    } catch (e) {
      _kfupmId = null;
      rethrow;
    }
  }

  void clearKfupmId() {
    _kfupmId = null;
    notifyListeners();
  }
}
