import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/blocks/darts_bloc.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';

class AppDrawer extends Drawer {
  final InAppUser person;
  final BuildContext context;
  const AppDrawer(this.context, this.person, {Key? key}) : super(key: key);

  Drawer buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.lightBlue[300],
        width: 200.0,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  DrawerHeader(person: person),
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

  final InAppUser person;
  // final Person person;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/drawer_header.jpg'),
        const SizedBox(
          height: 12.0,
        ),
        CircleAvatar(
          radius: 45.0,
          backgroundImage: getUserAvatar(),
        ),
        TextButton(
          onPressed: () {
            dartsBloc.openProfilScreen(context);
          },
          child: Text(
            person.firstName,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider<Object> getUserAvatar() {
    if (person.assetsPhoto != "") {
      return AssetImage('assets/personsphoto/${person.assetsPhoto}');
    } else if (person.urlPhoto != "") {
      return NetworkImage(person.urlPhoto);
    } else {
      return AssetImage('assets/user_anon.png');
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
            dartsBloc.openNewsScreen(context);
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
            dartsBloc.openStaffScreen(context);
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
            dartsBloc.signOut(context);
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
