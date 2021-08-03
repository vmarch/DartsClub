import 'package:flutter/material.dart';

import '../drawer/app_drawer.dart';
import '../../news_item.dart';
import '../../person.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

List<String> newsTitle = ['Unser Team ist super!', 'Grill-anmeldung'];

List<String> newsMessage = [
  '''Lorem ipsum dolor sit amet, 
consetetur sadipscing elitr, sed diam nonumy eirmod tempor
 invidunt ut labore et dolore magna aliquyam erat, sed diam 
 voluptua. At vero eos et accusam et''',
  '''Lorem ipsum dolor sit amet, consetetur 
 sadipscing elitr, sed diam nonumy eirmod tempor
  invidunt ut labore et dolore magna aliquyam erat, 
  sed diam voluptua. At vero eos et accusam et justo 
  duo dolores et ea rebum. Stet clita kasd gubergren, 
 no sea takimata sanctus est Lorem ipsum dolor sit amet.'''
];
List<String> newsImages = ['drawer_header.jpg', 'bbq.jpg'];

class _Home extends State<Home> {
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
    final items = List<Widget>.generate(2, (i) {
      NewsItem myItem = NewsItem(context, newsTitle.elementAt(i),
          newsMessage.elementAt(i), newsImages.elementAt(i));
      return myItem.createNewItem(context);
    });

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Dart Club "stich e.V."'),
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
      body: Column(
        children: [
          Container(
            height: 64,
            alignment: Alignment.center,
            child: const Text(
              'News',
              style: TextStyle(color: Colors.deepOrange, fontSize: 30.0),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                final item = items[index];
                return item;
              },
            ),
          ),
        ],
      ),
    );
  }

  getAppDrawer() {
    var appDrawer = AppDrawer(context, _person);
    return appDrawer.buildDrawer();
  }
}
