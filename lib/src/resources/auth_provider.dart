import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';

class AuthProvider {
//create user based on FirebaseUser
  final FirebaseAuth _auth = FirebaseAuth.instance;
  InAppUser? _inAppUser;

  // Stream<InAppUser?> currentUser() async* {
  //   StreamSubscription subscription = _auth
  //       .authStateChanges()
  //       .listen((user) => {inAppUser = _userFromFirebaseUser(user)});
  //   while (true) {
  //     yield inAppUser;
  //   }
  // }

  Stream<InAppUser?> getLoggedUser() async* {
    bool isResponced = false;
    bool closeStream = false;

    StreamSubscription<User?> sbs =
        _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      _inAppUser = _userFromFirebaseUser(user);

      isResponced = true;
    });

    while (!closeStream) {
      if (isResponced) {
        sbs.cancel();
        closeStream = true;
      }
      await Future.delayed((const Duration(milliseconds: 300)));
      yield _inAppUser;
    }
  }

  InAppUser? _userFromFirebaseUser(User? user) {
    return user != null ? InAppUser(uid: user.uid) : null;
  }

// sign in anon

  Future<InAppUser?> signInAnon() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      _inAppUser = _userFromFirebaseUser(userCredential.user);
      // User? user = userCredential.user;
      if (_inAppUser == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      return _inAppUser;
    } catch (e) {
      return null;
    }
  }

// sign in with Email and Password
  Future signInEmailAndPass(String userEmail, String userPass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!2");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

// register with Email and Password

  Future registerNewUser(String userEmail, String userPass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

//sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
