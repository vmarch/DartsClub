import 'package:flutter/material.dart';
import '../drawer/app_drawer.dart';
import '../../person.dart';
import '../../staff_list.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StaffHome(),
    );
  }
}

class StaffHome extends StatefulWidget {
  const StaffHome({Key? key}) : super(key: key);

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  Person person = Person()..getBaseUser();
  String _email = '';
  String _phone = '';

  void _setContacts({String email = 'unbekannt', String phone = 'unbekannt'}) {
    setState(() {
      _email = 'E-Mail: $email';
      _phone = 'Telefonnummer: $phone';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map> staffList = StaffList().getStaffList();

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
      body: Column(
        children: [
          const SizedBox(height: 64.0),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'Kontaktliste',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          Container(
            width: 300,
            child: Expanded(
              child: ListView.separated(
                itemCount: staffList.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  final staffPerson = staffList[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(


                        backgroundImage: getUserAvatar(staffPerson),
                      ),
                      title: Text(staffPerson['name']),
                      subtitle: Text(staffPerson['job']),
                      onTap: () {
                        _setContacts(
                            email: staffPerson['email'],
                            phone: staffPerson['phone']);
                      },
                    ),
                  );
                },
              ),
            ),
            height: 230,
          ),
          const SizedBox(height: 36.0),

          Container(
         
              color: Colors.white,
              height: 50,
              child: Column(
                children: [
                  Text(_phone),
                  Text(_email),
                ],
              ))
        ],
      ),
    );
  }


  ImageProvider<Object> getUserAvatar(Map<dynamic, dynamic> staffPerson) {
    if (staffPerson['assetsPhoto'] != "") {
     return AssetImage(staffPerson['assetsPhoto']);
    } else {
      return NetworkImage(staffPerson['urlPhoto']);
    }
  }

// Drawer is in separated Class.
  getAppDrawer(person) {
    var appDrawer = AppDrawer(context, person);
    return appDrawer.buildDrawer();
  }
}
