import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/blocks/auth_bloc.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  _AuthentoicateScreenState createState() => _AuthentoicateScreenState();
}

class _AuthentoicateScreenState extends State<AuthenticateScreen> {
  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {

    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Example App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: MaterialButton(
              color: Colors.indigo,
              child: Row(
                children: [
                  Icon(Icons.person_add),
                  Text('Registration'),
                ],
              ),
              // onPressed: () => _pushPage(context, RegisterPage()),
              onPressed: () => _pushPage(context,
                  authBloc.registerNewUser('emailll', 'ffff')),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: MaterialButton(
              color: Colors.orange,
              child: Row(
                children: [
                  Icon(Icons.verified_user),
                  Text('Sign In'),
                ],
              ),
              // onPressed: () => _pushPage(context, SignInPage()),
              onPressed: () => _pushPage(
                  context,
                  authBloc.authenticationEmailAndPass('emailll', 'ffff')),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: MaterialButton(
              color: Colors.teal,
              child: Row(
                children: [
                  Icon(Icons.device_unknown),
                  Text('Anonimously'),
                ],
              ),
              // onPressed: () => _pushPage(context, MainScreen()),
              onPressed: () => _pushPage(
                  context, authBloc.authenticationAnon()),
            ),
          ),
        ],
      ),
    );
  }
}
