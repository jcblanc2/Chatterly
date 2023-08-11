import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // firestore instance
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // sign in method
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  // sign up method
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create document for users
      firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email, 'fullname': name});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  // logout
  Future<void> signout() async {
    return await _firebaseAuth.signOut();
  }
}
