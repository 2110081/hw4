import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user_model.dart';
import 'dart:convert';


class UserApiScreen extends StatefulWidget {
  @override
  _UserApiScreenState createState() => _UserApiScreenState();
}

class _UserApiScreenState extends State<UserApiScreen> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  fetchUsers() async {
    final response = await http.get('https://randomuser.me/api/?results=10' as Uri);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final results = jsonData['results'] as List<dynamic>;
      final converted = results.map((user) {
        return User.fromJson(user);
      }).toList();

      setState(() {
        users = converted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User API Screen'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(users[index].name.first),
            trailing: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveUser(users[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: fetchUsers,
      ),
    );
  }
}

saveUser(User user) async {
  final db = await openDatabase(
    join(await getDatabasesPath(), 'users.db'),
  );

  await db.insert(
    'users',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
