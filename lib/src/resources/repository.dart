import 'dart:async';

import 'package:test_flutter_app/src/models/in_app_user.dart';
import 'package:test_flutter_app/src/resources/auth_provider.dart';
import 'package:test_flutter_app/src/resources/users_provider.dart';


class Repository {
 
  final _usersProvider = UsersProvider();

  final _authProvider = AuthProvider();

  InAppUser? _inAppUser;

  Stream<InAppUser?> getLoggedUser() async* {
      bool isResponced = false;
    bool closeStream = false;

    StreamSubscription<InAppUser?> sbs =
        _authProvider.getLoggedUser().listen((inAppUser) {
        _inAppUser = inAppUser;
      isResponced = true;
          });
      while (!closeStream) {
      if (isResponced) {
        closeStream = true;
        sbs.cancel();
               break;
      }
      await Future.delayed((const Duration(milliseconds: 300)));
          yield _inAppUser;
    }
  }

  Future<InAppUser?> authenticateAnon() async {
    return await _authProvider.signInAnon();
  }

  Future<Map<String,dynamic>> signInEmailAndPass(String userEmail, String userPass) async {
    return await _authProvider.signInEmailAndPass(userEmail, userPass);
  }

Future<Map<String,dynamic>> registerNewUser(String userEmail, String userPass) async {
    return await _authProvider.registerNewUser(userEmail, userPass);
  }


  Future<void> putUserIntoDB(InAppUser inAppUser)async{
    return await _usersProvider.updateUserFromUserItem(inAppUser);
  }

  Future<dynamic> signOut() async {
    return await _authProvider.signOut();
  }

  Future<InAppUser?> getCurrentUserFromDB(String uid) async {
    return await _usersProvider.getCurrentUserFromFireBase(uid);
  }
}
