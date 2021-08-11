import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../drawer/app_drawer.dart';
import 'package:test_flutter_app/src/models/person.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_app/record_news.dart';

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

class _Home extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Person _person = Person.dummmyPerson();
  List<Widget> _newsItems = [];

  Future<void> _getPrefPerson() async {
    SharedPreferences pref = await _prefs;
    setState(() {
      if (pref.get('person') != null) {
        _person = pref.get('person') as Person;
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
    ClubNews clubNews = ClubNews(context);
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
      body: clubNews.getClubNews(),
    );
  }

  getAppDrawer() {
    var appDrawer = AppDrawer(context, _person);
    return appDrawer.buildDrawer();
  }
}

class ClubNews {
  BuildContext context;
  List<Widget> _newsItems = [];
  ClubNews(this.context);

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> getClubNews() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('news').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasData) {
          // final data = snapshot.requireData;
          // setState(() {
          buildList(context, snapshot.data!.docs);
          // });
          return Column(
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
                  itemCount: _newsItems.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    final item = _newsItems[index];
                    return item;
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  buildList(BuildContext context, List<DocumentSnapshot> data) {
    _newsItems = List<Widget>.generate(data.length, (i) {
      RecordNews myItem = RecordNews.fromSnapshot(data[i]);
      return myItem.createNewItem();
    });
  }
}
