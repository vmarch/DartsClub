import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/blocks/auth_bloc.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_main.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
// Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {

    authBloc.initAuthentication(context);

    return Scaffold(
      backgroundColor: Colors.orange[600],
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: Text('Dart Club "stich e.V."'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello in Darts-Club App',
            )
          ],
        ),
      ),
    );
  }
}
