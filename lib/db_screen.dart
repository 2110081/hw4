import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  List users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  fetchUsers() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
    
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    setState(() {
      users = List.generate(maps.length, (i) {
        return User(
          name: maps[i]['name'],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Screen'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(users[index].name),
          );
        },
      ),
    );
  }
}

class User {
  final String name;

  User({required this.name});
}