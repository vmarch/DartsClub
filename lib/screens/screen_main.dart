
import 'package:flutter/material.dart';

import '../app_drawer.dart';
import '../news_item.dart';
import '../person.dart';

class MainScreen extends StatelessWidget {
  const MainScreen( {Key? key}) : super(key: key);

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
  Person person = Person();

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

      // ERROR

      //   body: Column(
      //     children: [
      //       const Text(
      //         'News',
      //         style: TextStyle(color: Colors.deepOrange, fontSize: 30.0),
      //       ),
      //       ListView.separated(
      //         physics: NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           scrollDirection: Axis.vertical,
      //
      //         itemCount: items.length,
      //         separatorBuilder: (context, index) {
      //           return const Divider();
      //         },
      //         itemBuilder: (context, index) {
      //           final item = items[index];
      //           return item;
      //         },
      //       ),
      //     ],
      //   ),
      // );
    );
  }

  getAppDrawer(person) {
    var appDrawer = AppDrawer(context,person);
    return appDrawer.buildDrawer();
  }
}
