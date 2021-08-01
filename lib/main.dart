import 'package:flutter/material.dart';

import 'main_activity.dart';
import 'staff_activity.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Dart Club "stich e.V."',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: 'mainActivity',
      routes: {
        'mainActivity': (context) => const MainActivity(),
        'staffActivity': (context) => const StaffActivity(),
      },
    ),
  );
}
