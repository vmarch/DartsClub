import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_flutter_app/src/blocks/darts_bloc.dart';
import 'package:test_flutter_app/src/models/in_app_user.dart';
import 'package:test_flutter_app/src/models/news_item.dart';
import 'package:test_flutter_app/src/ui/drawer/app_drawer.dart';



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
  InAppUser? _person = InAppUser();
  List<Widget> _newsItems = [];

  Future<void> _getcurrentUser() async {
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
    _getcurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    ClubNews clubNews = ClubNews(context);
    return Scaffold(
      backgroundColor: Colors.blue[100],
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
    var appDrawer = AppDrawer(context, _person!);
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
                height: 36,
                alignment: Alignment.center,
                child:  Text(
                  'News',
                  style: TextStyle(color: Colors.blueGrey[900], fontSize: 24.0),
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
      NewsItem myItem = NewsItem.fromSnapshot(data[i]);
      return myItem.createNewItem();
    });
  }
}
