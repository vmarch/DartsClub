import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';
import 'package:test_flutter_app/src/resources/repository.dart';
import 'package:test_flutter_app/src/ui/screens/authenticate/screen_login.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_main.dart';

import 'bloc.dart';

class AuthenticateBloc implements Bloc {
  BuildContext? context;
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

  void cleanAllLoginData() {
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

  String isPasswordHard() {
    if (_password.isNotEmpty && _passwordRepeat.isNotEmpty) {
      if (_password.length < 6) {
        return 'Password can not be less then 6 symbol';
      } else {
        return _password == _passwordRepeat ? 'ok' : 'Password are NOT equal.';
      }
    } else if (_password.isEmpty && _passwordRepeat.isNotEmpty) {
      return 'Write Password';
    } else if (_password.isNotEmpty && _passwordRepeat.isEmpty) {
      return 'Confirm the Password';
    } else if (_password.isEmpty && _passwordRepeat.isEmpty) {
      return 'Write Password';
    } else {
      return 'Error';
    }
  }

  String isPasswordNotEmpty() {
    if (_password.isEmpty || _password == '') {
      return 'Password is empty!';
    } else {
      return 'ok';
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
          _pushPage(context!, const MainScreen());
        } else {
          _pushPage(context!, const LoginScreen());

          // Navigator.push(
          //   context!,
          //   MaterialPageRoute(
          //     builder: (context) => const AuthenticateScreen(),
          //   ),
          // );
        }
        isResponced = true;
      }
    });
  }

  void authenticationAnon() {
    dynamic result = _repository.authenticateAnon();
    if (result != null) {
      _pushPage(context!, const MainScreen());
    } else {
      //TODO error
      _pushPage(context!, const LoginScreen());
      // return const AuthenticateScreen();
    }
  }

  Future<String> loginWithEmailAndPass(
      String userEmail, String userPass) async {
    Map<String, dynamic> result =
        await _repository.signInEmailAndPass(userEmail, userPass);

    if (result['user'] != null && result['user'].uid.isNotEmpty) {
      InAppUser inAppUser = result['user'];

      inAppUser.email = _email;
      inAppUser.password = _password;

//TODO do something with UsersData from InAppUser.

      _pushPage(context!, const MainScreen());
      return '';
    } else {
      String errorCode = result['errorCode'];
      String errorMessage = result['errorMessage'];

      if (errorMessage.isNotEmpty) {
        return errorMessage;
      } else {
        return errorCode;
      }
    }
  }

  Future<String> registerNewUser(String userEmail, String userPass) async {
    Map<String, dynamic> result =
        await _repository.registerNewUser(userEmail, userPass);

    if (result['user'] != null && result['user'].uid.isNotEmpty) {
      InAppUser inAppUser = result['user'];

      inAppUser.email = _email;
      inAppUser.password = _password;

//TODO do something with UsersData from InAppUser.

//////////////////////////////////////////////////////////////////////
      registerOnServer();
//////////////////////////////////////////////////////////////////////
      return 'After registration on server you will transfer to HomePage of Darts-Club App';
    } else {
      String errorCode = result['errorCode'];
      String errorMessage = result['errorMessage'];

      if (errorMessage.isNotEmpty) {
        return errorMessage;
      } else {
        return errorCode;
      }
    }
  }

  void registerOnServer() {
    // _pushPage(context!, const MainScreen());
  }

  Future<String> login(BuildContext ctx) async {
    context ??= ctx;
    String result = isPasswordNotEmpty();
    print(result);
    if (_email.isEmpty) {
      return 'Email can not be empty!';
    } else if (result != 'ok') {
      return result;
    } else {
      return await loginWithEmailAndPass(_email, _password);
    }
  }

  Future<String> register(BuildContext ctx) async {
    context ??= ctx;

    String result = isPasswordHard();
    print(result);
    if (_email.isEmpty) {
      return 'Email can not be empty!';
    } else if (result != 'ok') {
      return result;
    } else {
      return await registerNewUser(_email, _password);
    }
  }

  void loginAnonym(BuildContext ctx) {
    context ??= ctx;
    cleanAllLoginData();
    authenticationAnon();
  }

  void signOut(BuildContext ctx) {
    context ??= ctx;
    cleanAllLoginData();
    dynamic result = _repository.signOut();
    if (result != null) {
      print(result);
      //TODO get result info

      //TODO error
      _pushPage(context!, const LoginScreen());
    } else {
      _pushPage(context!, const LoginScreen());
    }
  }

  @override
  void dispose() {
    print('dispose() invoked');
    sbs.cancel();
  }
}

final authBloc = AuthenticateBloc();
