import 'package:flutter/material.dart';
import 'package:test_flutter_app/src/ui/screens/authenticate/screen_authenticate.dart';
import 'package:test_flutter_app/src/wrapper.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_main.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_profil.dart';
import 'package:test_flutter_app/src/ui/screens/home/screen_staff.dart';
import 'package:firebase_core/firebase_core.dart';


//import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
     
      title: 'Dart Club "stich e.V."',
      // initialRoute: 'authScreen',
      routes: {
        'authScreen': (context) => const AuthenticateScreen(),
        'mainScreen': (context) => const MainScreen(),
        'staffScreen': (context) => const StaffScreen(),
        'userProfilScreen': (context) => const UserProfilScreen(),
      },
      home: const Wrapper(),
    ),
  );
  // print('System: ${Platform.operatingSystem} ');
}
