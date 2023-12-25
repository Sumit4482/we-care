// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_care/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        print('User ID: ${user.uid}');
        print('User Email: ${user.email}');
        // Access other user properties as needed
        return user;
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error getting current user: $e');
    }
    return null;
  }

  Future<void> signUp(Userr user) async {
    try {
      // Create user with email and password
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Save additional user information to Firestore
      await _firestore.collection('users').doc(authResult.user!.uid).set(
            user.toMap(),
          );
    } catch (e) {
      print('Error signing up: $e');
      rethrow;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      // Your authentication logic here, e.g., using FirebaseAuth
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the signed-in user
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      // Handle login error (e.g., show error message to the user)

      // Return null to indicate sign-in failure
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
