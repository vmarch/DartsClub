import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/blocks/auth_bloc.dart';
import 'package:test_flutter_app/src/models/person.dart';
import '../screens/home/screen_staff.dart';

class AppDrawer extends Drawer {
  final Person person;
  final BuildContext context;
  const AppDrawer(this.context, this.person, {Key? key}) : super(key: key);

  Drawer buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.amber[600],
        width: 200.0,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  DrawerHeader(person: person),
                  const SizedBox(
                    height: 16.0,
                  ),
                  setDivider(),
                  DrawerMenu(context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    Key? key,
    required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/drawer_header.jpg'),
        const SizedBox(
          height: 16.0,
        ),
        CircleAvatar(
          radius: 45.0,
          backgroundImage: getUserAvatar(),
        ),
        Text(
          person.name,
          style: TextStyle(
            color: Colors.amber[600],
            backgroundColor: Colors.black,
          ),
        ),
      ],
    );
  }

  ImageProvider<Object> getUserAvatar() {
    if (person.assetsPhoto != "") {
      return AssetImage('assets/personsphoto/${person.assetsPhoto}');
    } else {
      return NetworkImage(person.urlPhoto);
    }
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
      return Column(
      children: [
        ListTile(
          title: const Text('News'),
          leading: const Icon(Icons.event_available),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Bestenliste'),
          leading: const Icon(Icons.emoji_events),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Mitglieder'),
          leading: const Icon(Icons.family_restroom_rounded),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        setDivider(),
        ListTile(
          title: const Text('Support'),
          leading: const Icon(Icons.support_agent_rounded),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StaffScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('Einstellungen'),
          leading: const Icon(Icons.settings),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        setDivider(),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
          onTap: () {
             authBloc.signOut(context);
          },
        ),
      ],
    );
  }
}

Divider setDivider() {
  return Divider(
    height: 8.0,
    thickness: 1.0,
    color: Colors.grey[700],
  );
}

void _pushPage(BuildContext context, Widget page) {

  Navigator.of(context) /*!*/ .push(
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
