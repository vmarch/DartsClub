import 'dart:async';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';
import 'package:test_flutter_app/src/resources/repository.dart';
import 'package:test_flutter_app/src/ui/screens/authenticate/screen_authenticate.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_main.dart';

import 'bloc.dart';

class AuthenticateBloc implements Bloc {
  late BuildContext? context;
  final _repository = Repository();
  InAppUser? _inAppUser;
  late StreamSubscription<InAppUser?> sbs;
  String _firstName = '';
  String _lastName = '';
  String _nick = '';
  String _city = '';
  String _phone = '';

  String _email = '';
  String _password = '';
  String _passwordRepeat = '';

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void firstName(String firstName) {
    _firstName = firstName;
  }

  void lastName(String lastName) {
    _lastName = lastName;
  }

  void nick(String nick) {
    _nick = nick;
  }

  void city(String city) {
    _city = city;
  }

  void phone(String phone) {
    _phone = phone;
  }

  void email(String email) {
    _email = email;
  }

  void password(String pass) {
    _password = pass;
  }

  void passwordRepeat(String passwordRepeat) {
    _passwordRepeat = passwordRepeat;
  }

  void cleanLoginData() {
    _firstName = '';
    _lastName = '';
    _nick = '';
    _city = '';
    _phone = '';
    _email = '';
    _password = '';
    _passwordRepeat = '';
  }

  void cleanFormData() {
    _firstName = '';
    _lastName = '';
    _nick = '';
    _city = '';
    _phone = '';
    _passwordRepeat = '';
  }

  String isPasswordEqual() {
    if (_password.isNotEmpty && _passwordRepeat.isNotEmpty) {
      return _password == _passwordRepeat ? 'ok' : 'Password are NOT equal.';
    } else if (_password.isEmpty && _passwordRepeat.isNotEmpty) {
      return 'Write first Password';
    } else if (_password.isNotEmpty && _passwordRepeat.isEmpty) {
      return 'Confirm the Password';
    } else if (_password.isEmpty && _passwordRepeat.isEmpty) {
      return 'Write Password';
    } else {
      return 'Error';
    }
  }

  // void getCurrentLoggedUser() {
  //   _repository.currentUser;
  // }

  Future<void> initAuthentication(BuildContext ctx) async {
     context ??= ctx;
    bool isResponced = false;
    sbs = _repository.getLoggedUser().listen((inAppUser) {
      _inAppUser = inAppUser;

      if (!isResponced) {
        if (inAppUser != null) {
          Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        } else {
          Navigator.push(
            context!,
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
      return const MainScreen();
    } else {
      //TODO error
      return const AuthenticateScreen();
    }
  }

  Widget authenticationEmailAndPass(String userEmail, String userPass) {
    dynamic result = _repository.signInEmailAndPass(userEmail, userPass);
    if (result != null) {
      return const MainScreen();
    } else {
      //TODO error
      return const AuthenticateScreen();
    }
  }

  Widget registerNewUser(String userEmail, String userPass) {
    dynamic result = _repository.registerNewUser(userEmail, userPass);
    if (result != null) {
      return const MainScreen();
    } else {
      //TODO error
      return const AuthenticateScreen();
    }
  }

  Widget signOut() {
    dynamic result = _repository.signOut();
    if (result != null) {
      print(result);
      //TODO get result info

      //TODO error
      return const AuthenticateScreen();
    } else {
      return const AuthenticateScreen();
    }
  }

  void login(BuildContext ctx) {
    context ??= ctx;



  }

  @override
  void dispose() {
    print('dispose() invoked');
    sbs.cancel();
  }
}

final authBloc = AuthenticateBloc();
