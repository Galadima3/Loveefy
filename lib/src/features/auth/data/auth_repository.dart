import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> registerUsingEmailPassword({
    
    required String email,
    required String password,
  }) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      // await user!.updateDisplayName(name);
      await user!.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided.');
      }
    }
    return user;
  }

  Future<void> signOut() async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  
}
