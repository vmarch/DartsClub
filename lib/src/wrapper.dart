import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/blocks/darts_bloc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
// Navigates to a new page
  // void _pushPage(BuildContext context, Widget page) {
  //   Navigator.of(context) /*!*/ .push(
  //     MaterialPageRoute<void>(builder: (_) => page),
  //   );
  // }

  @override
  Widget build(BuildContext context) {

    dartsBloc.initAuthentication(context);

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
    
        title: const Text('Dart Club "stich e.V."'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Hello in Darts-Club App',
              style: TextStyle(fontSize: 34,color: Colors.indigo[900]),),
            )
          ],
        ),
      ),
    );
  }
}
