/// Repository class for Authentication.
/// 
/// This class handles all direct interactions with Firebase Auth, providing
/// a cleaner interface for the rest of the application. It handles login,
/// signup, logout, and checking current user status.
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  /// Signs in a user using email and password.
  /// 
  /// Throws an [Exception] with a user-friendly message if login fails.
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseErrorCode(e.code));
    } catch (e) {
      throw Exception('An unexpected error occurred during login.');
    }
  }

  /// Registers a new user using email and password.
  /// 
  /// Throws an [Exception] with a user-friendly message if signup fails.
  Future<void> signup(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseErrorCode(e.code));
    } catch (e) {
      throw Exception('An unexpected error occurred during signup.');
    }
  }

  /// Signs out the current user.
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  /// Checks if there is a currently authenticated user.
  Future<bool> checkLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  /// Returns the email of the currently logged-in user, if any.
  Future<String?> getUserEmail() async {
    return _firebaseAuth.currentUser?.email;
  }

  /// Maps Firebase-specific error codes to user-friendly error messages.
  String _mapFirebaseErrorCode(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-credential':
        return 'Invalid credentials provided.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
