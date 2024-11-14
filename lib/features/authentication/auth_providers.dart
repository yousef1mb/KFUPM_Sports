import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_repository.dart';

part 'auth_providers.g.dart'; // Generated file

// Auto-generate the FirebaseAuth provider
@riverpod
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

// Auto-generate the AuthRepository provider
@riverpod
AuthRepository authRepository(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRepository(firebaseAuth);
}
