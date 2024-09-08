import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;
  User? get user {
    return _user;
  }

  // Corrected constructor name
  AuthServices() {
    _firebaseAuth.authStateChanges().listen(authStatechangeStreamListener);
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) { // Use != null instead of != Null
        _user = credential.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> logIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) { // Use != null instead of != Null
        _user = credential.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void authStatechangeStreamListener(User? user) {
    if (user != null) {
      _user = user;
      print("User logged in: ${user.uid}");
    } else {
      _user = null;
      print("User logged out");
    }
  }
}
