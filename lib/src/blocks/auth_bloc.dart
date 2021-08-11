import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';
import 'package:test_flutter_app/src/resources/repository.dart';
import 'package:test_flutter_app/src/ui/screens/authenticate/screen_authenticate.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_main.dart';

import 'bloc.dart';

class AuthenticateBloc implements Bloc {
  final _repository = Repository();
  InAppUser? _inAppUser;
  late StreamSubscription<InAppUser?> sbs;

  // void getCurrentLoggedUser() {
  //   _repository.currentUser;
  // }

  Future<void> authentication(BuildContext ctx) async {
    bool isResponced = false;
    sbs = _repository.getLoggedUser().listen((inAppUser) {
      _inAppUser = inAppUser;

      if (!isResponced) {
        if (inAppUser != null) {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        } else {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => const AuthenticateScreen(),
            ),
          );
        }
        isResponced = true;
      }
    });
  }

  Widget authenticationAnon() {
    dynamic result = _repository.authenticateAnon();
    if (result != null) {
      return MainScreen();
    } else {
      //TODO error
      return AuthenticateScreen();
    }
  }

  Widget authenticationEmailAndPass(String userEmail, String userPass) {
    dynamic result = _repository.signInEmailAndPass(userEmail, userPass);
    if (result != null) {
      return MainScreen();
    } else {
      //TODO error
      return AuthenticateScreen();
    }
  }

  Widget registerNewUser(String userEmail, String userPass) {
    dynamic result = _repository.registerNewUser(userEmail, userPass);
    if (result != null) {
      return MainScreen();
    } else {
      //TODO error
      return AuthenticateScreen();
    }
  }

  Widget signOut() {
    dynamic result = _repository.signOut();
    if (result != null) {
      print(result);
      //TODO get result info

      //TODO error
      return AuthenticateScreen();
    } else {
      return AuthenticateScreen();
    }
  }

  @override
  void dispose() {
    print('dispose() invoked');
    sbs.cancel();
  }
}

final authBloc = AuthenticateBloc();