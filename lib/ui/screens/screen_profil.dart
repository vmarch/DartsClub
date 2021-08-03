import 'package:flutter/material.dart';

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
  Person person = Person()..getBaseUser();

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
              print('pressed Calendar');
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              print('pressed Share');
            },
          ),
        ],
      ),
      drawer: getAppDrawer(person),
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
                Text(person.name),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Nachname:')),
                setVerticalDivider(),
                Text(person.surName),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('E-Mail:')),
                setVerticalDivider(),
                Text(person.email),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Status:')),
                setVerticalDivider(),
                Text(person.staff ? person.job : 'Mitglied' ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Name')),
                setVerticalDivider(),
                Text(person.name),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 50, child: Text('Name')),
                setVerticalDivider(),
                Text(person.name),
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
    if (person.assetsPhoto != "") {
      return AssetImage(person.assetsPhoto);
    } else {
      return NetworkImage(person.urlPhoto);
    }
  }


  getAppDrawer(person) {
    var appDrawer = AppDrawer(context, person);
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
