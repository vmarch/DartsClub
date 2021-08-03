import 'package:flutter/material.dart';

import 'ui/screens/screen_main.dart';
import 'ui/screens/screen_profil.dart';
import 'ui/screens/screen_staff.dart';
//import 'dart:io';

void main() {
  runApp(
    MaterialApp(
      title: 'Dart Club "stich e.V."',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: 'mainScreen',
      routes: {
        'mainScreen': (context) => const MainScreen(),
        'staffScreen': (context) => const StaffScreen(),
        'userProfilScreen': (context) => const UserProfilScreen(),
      },
    ),
  );
  // print('System: ${Platform.operatingSystem} ');
}
