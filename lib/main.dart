import 'package:flutter/material.dart';
import 'package:momentum_bank/app/login/view/login_screen.dart';

import 'app/utils/app_preferences.dart';

Future<void> main() async {
  runApp(MyApp());
  await appPreferences.init();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentum',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }
}
