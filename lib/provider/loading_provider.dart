import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lcpl_academy/screens/homescreen/home_screen.dart';
import 'package:lcpl_academy/utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _loading = false;

  bool get loading => _loading;
  User? get user => _user;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      setLoading(true);
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } catch (e) {
      // Handle error (e.g., show a toast message)
      Utils.toastMessage(message: 'Login failed. Please try again.');
    } finally {
      setLoading(false);
    }
  }

  Future<void> signUpWithEmail(String email, String password,BuildContext context) async {
    try {
      setLoading(true);
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password) .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } catch (e) {
      Utils.toastMessage(message: 'Signup failed. Please try again');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Handle error (e.g., show a toast message)
      Utils.toastMessage(message: 'Logout failed. Please try again.');
    }
  }
}
