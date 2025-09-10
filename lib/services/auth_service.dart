import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user or non
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Create Account
  Future<UserCredential?> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Update Display name
  Future<void> updateDisplayName({required String username}) async {
    await _auth.currentUser?.updateDisplayName(username);
  }

  // Sign In
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Sign Out
  Future<void> signOut() => _auth.signOut();

  // Delete Account
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    } else {
      throw FirebaseAuthException(
        code: "no-user",
        message: "No user is currently signed in.",
      );
    }
  }
}
