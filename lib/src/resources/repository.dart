import 'dart:async';

import 'package:test_flutter_app/src/models/in_app_user.dart';
import 'package:test_flutter_app/src/resources/auth_provider.dart';

import 'news_provider.dart';

class Repository {
  final _newsProvider = NewsProvider();

  final _authProvider = AuthProvider();

  InAppUser? _inAppUser;

  // set currentUser(InAppUser? inAppUser) {
  //   _inAppUser = inAppUser;
  // }

  InAppUser? get currentUser {
    return _inAppUser;
  }

  Stream<InAppUser?> getLoggedUser() async* {
    print('repository 1');

    bool isResponced = false;
    bool closeStream = false;

    StreamSubscription<InAppUser?> sbs =
        _authProvider.getLoggedUser().listen((inAppUser) {
        
      print('repository 2');

      _inAppUser = inAppUser;
      isResponced = true;
      print('repository 3');
    });
    print('repository 4');
    while (!closeStream) {
      if (isResponced) {
        closeStream = true;
        sbs.cancel();
          print('repository 5');
        break;
      }
      await Future.delayed((const Duration(milliseconds: 300)));
          print('repository 6');
      yield _inAppUser;
    }
  }

  // Future<InAppUser?> checkCurrentUser() async {
  //   _inAppUser = await _authProvider.getLoggedUser();

  //   return _authProvider.getLoggedUser();
  // }

  Future<InAppUser?> authenticateAnon() async {
    return await _authProvider.signInAnon();
  }

  Future<dynamic> signInEmailAndPass(String userEmail, String userPass) async {
    return await _authProvider.signInEmailAndPass(userEmail, userPass);
  }

  Future<dynamic> registerNewUser(String userEmail, String userPass) async {
    return await _authProvider.registerNewUser(userEmail, userPass);
  }

  Future<dynamic> signOut() async {
    return await _authProvider.signOut();
  }
}
