import 'package:flutter/material.dart';
import 'screen2.dart';
import 'welcome_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/userApi': (context) => const UsersScreen(),
      },
    );
  }
}