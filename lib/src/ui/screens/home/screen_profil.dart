import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_app/src/blocks/darts_bloc.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';

import '../../drawer/app_drawer.dart';
import 'package:test_flutter_app/src/models/person.dart';

class UserProfilScreen extends StatelessWidget {
  const UserProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserProfileHome(),
    );
  }
}

class UserProfileHome extends StatefulWidget {
  const UserProfileHome({Key? key}) : super(key: key);

  @override
  State<UserProfileHome> createState() => _UserProfileHome();
}

class _UserProfileHome extends State<UserProfileHome> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  InAppUser? _person = InAppUser();

  Future<void> _getPrefPerson() async {
    // SharedPreferences pref = await _prefs;
    InAppUser? person = await dartsBloc.getCurrentLoggedUser();

    setState(() {
      if (person != null && person.firstName.isNotEmpty) {
        _person = person;
      } else {
        _person!.firstName = 'Inkognito';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getPrefPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text('Dart Club "stich e.V."'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              //TODO  print('pressed Calendar');
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              //TODO  print('pressed Share');
            },
          ),
        ],
      ),
      drawer: getAppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
          padding: const EdgeInsets.only(top:16.0),
              child: Image(
                image: getUserAvatar(),
                height: 100.0,
                width: 100.0,
              ),
            ),
            Divider(color: Colors.grey,height: 16.0,),
            Row(
              children: [
                Expanded(
                  child: Container(height: 24, child: const Text('Vorname:')),
                ),
                Expanded(
                  child: Container(height: 24,child: Text(_person!.firstName)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(height: 24,child: const Text('Nachname:')),
                ),
                Expanded(
                  child: Container(height: 24,child: Text(_person!.lastName)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(height: 24,child: const Text('E-Mail:')),
                ),
                Expanded(
                  child: Container(height: 24,child: Text(_person!.email)),
                ),
              ],
            ),
            
            Row(
              children: [
                Expanded(
                  child: Container(height: 24,child: const Text('Phone:')),
                ),
                Expanded(
                  child: Container(height: 24,child: Text(_person!.phone)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(height: 24,child: const Text('City')),
                ),
                Expanded(
                  child: Container(height: 24,child: Text(_person!.city)),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(height: 24,child: const Text('Passwort')),
                ),
                Expanded(
                  child: Container(height: 24,child: Text(_person!.password)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> getUserAvatar() {
    if (_person!.assetsPhoto != "") {
      return AssetImage(_person!.assetsPhoto);
    } else if (_person!.urlPhoto != ""){
      return NetworkImage(_person!.urlPhoto);
    }else{
return AssetImage('assets/user_anon.png');
    
    }
  }

  getAppDrawer() {
    var appDrawer = AppDrawer(context, _person!);
    return appDrawer.buildDrawer();
  }
}
