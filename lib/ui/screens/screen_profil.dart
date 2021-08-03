import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../drawer/app_drawer.dart';
import '../../person.dart';

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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Person _person = Person()..getBaseUser();

  Future<void> _getPrefPerson() async {
    SharedPreferences pref = await _prefs;
    setState(() {
      _person = pref.get('person') as Person;
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
            CircleAvatar(
              backgroundImage: getUserAvatar(),
              radius: 100.0,
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Vorname:')),
                setVerticalDivider(),
                Text(_person.name),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Nachname:')),
                setVerticalDivider(),
                Text(_person.surName),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('E-Mail:')),
                setVerticalDivider(),
                Text(_person.email),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Status:')),
                setVerticalDivider(),
                Text(_person.staff ? _person.job : 'Mitglied'),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Name')),
                setVerticalDivider(),
                Text(_person.name),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Name')),
                setVerticalDivider(),
                Text(_person.name),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Passwort')),
                setVerticalDivider(),
                const Text('*********'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> getUserAvatar() {
    if (_person.assetsPhoto != "") {
      return AssetImage(_person.assetsPhoto);
    } else {
      return NetworkImage(_person.urlPhoto);
    }
  }

  getAppDrawer() {
    var appDrawer = AppDrawer(context, _person);
    return appDrawer.buildDrawer();
  }
}

VerticalDivider setVerticalDivider() {
  return VerticalDivider(
    width: 16.0,
    thickness: 1.0,
    color: Colors.grey[700],
  );
}
