import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userapi_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new UserApiScreen()));
    } else {
      await prefs.setBool('seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to Our App', style: TextStyle(fontSize: 24)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (context) => new UserApiScreen()));
                },
                child: Text('Start', style: TextStyle(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}