import 'package:flutter/material.dart';
import 'package:test_flutter_app/person.dart';
import 'package:test_flutter_app/staff_activity.dart';

class AppDrawer extends Drawer {
  final Person person;
  final BuildContext context;
  const AppDrawer(this.context, this.person, {Key? key}) : super(key: key);

  Drawer buildDrawer() {
    return Drawer(
      //child: Text('Hallo aus dem Drawer'),
      child: Container(
        color: Colors.amber[600],
        width: 200.0,
        child: Column(
          children: [
            DrawerHeader(person: person),
            const SizedBox(
              height: 45.0,
            ),
            setDivider(),
            DrawerMenu(context: context),
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
        Image.asset('drawer_header.jpg'),
        const SizedBox(
          height: 45.0,
        ),
        Text(
          person.firstName,
          style: TextStyle(
            color: Colors.amber[600],
            backgroundColor: Colors.black,
          ),
        ),
        CircleAvatar(
          backgroundImage: AssetImage(person.urlPhoto),
          radius: 45.0,
        ),
      ],
    );
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
        MaterialButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const StaffActivity()),
            // );
          },
          child: Row(
            children: [
              const Icon(Icons.portrait_rounded),
              const Text('Profil'),
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const StaffActivity()),
            // );
          },
          child: Row(
            children: [const Icon(Icons.event_available), const Text('News')],
          ),
        ),
        MaterialButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const StaffActivity()),
            // );
          },
          child: Row(
            children: [
              const Icon(Icons.emoji_events),
              const Text('Bestenliste')
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const StaffActivity()),
            // );
          },
          child: Row(
            children: [
              const Icon(Icons.family_restroom_rounded),
              const Text('Mitglieder')
            ],
          ),
        ),
        setDivider(),
        MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StaffActivity()),
            );
          },
          child: Row(
            children: [
              const Icon(Icons.support_agent_rounded),
              const Text('Support'),
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const StaffActivity()),
            // );
          },
          child: Row(
            children: [const Icon(Icons.settings), const Text('Einstellungen')],
          ),
        ),
        setDivider(),
        MaterialButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const StaffActivity()
            //       ),
            // );
          },
          child: Row(
            children: [const Icon(Icons.logout), const Text('Logout')],
          ),
        ),
      ],
    );
  }
}

Divider setDivider() {
  return Divider(
    height: 16.0,
    thickness: 1.0,
    color: Colors.grey[700],
  );
}
