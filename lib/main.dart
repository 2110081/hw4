import 'package:flutter/material.dart';
import 'db_screen.dart';
import 'userapi_screen.dart';
import 'welcome_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/userApi': (context) => UserApiScreen(),
        '/database': (context) => DatabaseScreen(),
      },
    );
  }
}