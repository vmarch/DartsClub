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
        print('AuthProvider>>> User is currently signed out!');
      } else {
        print('AuthProvider>>> User is signed in!');
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
    print('AuthProvider>>> my user: ' + user.toString());

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
        print('AuthProvider>>>  User is currently signed out!');
      } else {
        print('AuthProvider>>>  User is signed in!');
      }
      return _inAppUser;
    } catch (e) {
      print('AuthProvider>>> $e');
      return null;
    }
  }

// sign in with Email and Password

  Future<Map<String, dynamic>> signInEmailAndPass(
      String userEmail, String userPass) async {
    var errorCode = '';
    var errorMessage = '';

    var loginInfo = <String, dynamic>{};

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPass);
      _inAppUser = _userFromFirebaseUser(userCredential.user);
      loginInfo['user'] = _inAppUser;
      loginInfo['errorCode'] = errorCode;
      loginInfo['errorMessage'] = errorMessage;
      return loginInfo;
    } on FirebaseAuthException catch (e) {
      loginInfo['errorCode'] = e.code;
      loginInfo['errorMessage'] = e.message ?? '';
      return loginInfo;
    }
  }

// register with Email and Password

  Future<Map<String, dynamic>> registerNewUser(
      String userEmail, String userPass) async {
    var errorCode = '';
    var errorMessage = '';

    var registerInfo = <String, dynamic>{};

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: userPass);
      _inAppUser = _userFromFirebaseUser(userCredential.user);
      registerInfo['user'] = _inAppUser;
      registerInfo['errorCode'] = errorCode;
      registerInfo['errorMessage'] = errorMessage;
      return registerInfo;
    } on FirebaseAuthException catch (e) {
      registerInfo['errorCode'] = e.code;
     registerInfo['errorMessage'] = e.message ?? '';
      return registerInfo;
    }
  }

//sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
