import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  String? _verificationId; // Store verification ID for later use

  // Method to send OTP
  Future<void> sendOtp(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      // Called when automatic verification is completed (on supported devices)
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await _firebaseAuth.signInWithCredential(credential);
          print('Phone number automatically verified and user signed in');
        } catch (e) {
          print('Error during automatic verification: $e');
        }
      },

      // Called if the verification process fails
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed with error: ${e.message}');
        throw e; // You could also handle the error more specifically if needed
      },

      // Called when the code has been successfully sent to the user
      codeSent: (String verificationId, int? resendToken) {
        // Store the verification ID for later use
        _verificationId = verificationId;
        print('Verification code sent to the phone number');
      },

      // Called if the code retrieval times out
      codeAutoRetrievalTimeout: (String verificationId) {
        // Save verification ID to allow re-verification
        _verificationId = verificationId;
        print('Code retrieval timeout');
      },
    );
  }

  // Method to verify the OTP code entered by the user
  Future<UserCredential> verifyOtp(String smsCode) async {
    if (_verificationId == null) {
      throw Exception(
          'No verification ID found. You need to send the OTP first.');
    }

    // Create the phone auth credential with the verification ID and the entered SMS code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    // Sign in the user with the credential
    return await _firebaseAuth.signInWithCredential(credential);
  }
}
