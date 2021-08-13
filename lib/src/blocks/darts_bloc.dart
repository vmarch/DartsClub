import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';
import 'package:test_flutter_app/src/resources/repository.dart';
import 'package:test_flutter_app/src/ui/screens/authenticate/screen_login.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_main.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_profil.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_staff.dart';

import 'bloc.dart';

class DartsBloc implements Bloc {
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
    _inAppUser = null;
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

  Future<InAppUser?> getCurrentLoggedUser() async {
    if (_inAppUser != null && _inAppUser!.uid.isNotEmpty) {
      return await _repository.getCurrentUserFromDB(_inAppUser!.uid);
    } else {
      return null;
    }
  }

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
      //TODO check of type of error
      _pushPage(context!, const LoginScreen());
    }
  }

  Future<String> loginWithEmailAndPass(
      String userEmail, String userPass) async {
    Map<String, dynamic> result =
        await _repository.signInEmailAndPass(userEmail, userPass);

    if (result['user'] != null && result['user'].uid.isNotEmpty) {
      _inAppUser = result['user'];

      _fillInAppUser();
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
      _inAppUser = result['user'];

      registerUserOnServer();

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

  InAppUser _fillInAppUser() {
    if (_firstName.isNotEmpty) {
      _inAppUser!.firstName = _firstName;
    }
    if (_lastName.isNotEmpty) {
      _inAppUser!.lastName = _lastName;
    }
    if (_nick.isNotEmpty) {
      _inAppUser!.nick = _nick;
    }
    if (_city.isNotEmpty) {
      _inAppUser!.city = _city;
    }
    if (_phone.isNotEmpty) {
      _inAppUser!.phone = _phone;
    }
    _inAppUser!.email = _email;
    _inAppUser!.password = _password;

    return _inAppUser!;
  }

  void registerUserOnServer() {
    _repository.putUserIntoDB(_fillInAppUser());
    _pushPage(context!, const MainScreen());
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

  void signOut(BuildContext ctx) async {
    context ??= ctx;
    cleanAllLoginData();
    dynamic result = await _repository.signOut();
    _pushPage(context!, const LoginScreen());
  }

  void openNewsScreen(BuildContext ctx) {
    _pushPage(context!, const MainScreen());
  }

  void openProfilScreen(BuildContext ctx) {
    _pushPage(context!, const UserProfilScreen());
  }

    void openStaffScreen(BuildContext ctx) {
    _pushPage(context!, const StaffScreen());
  }

  @override
  void dispose() {
    print('dispose() invoked');
    //cancel StreamSubscription
    sbs.cancel();
  }
}

final dartsBloc = DartsBloc();
