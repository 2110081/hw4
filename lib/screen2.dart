import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'db_helper.dart';
import 'models.dart';
import 'screen3.dart';



class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UserApiScreenState();
}

class _UserApiScreenState extends State<UsersScreen> {
  List<dynamic> listOfUsers = [];
  List<User> selectedUsers = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Users'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: listOfUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = listOfUsers[index];
                  return ListTile(
                    title: Text('${user.name.first} ${user.name.last}'),
                    subtitle: Text(user.email),
                    trailing: Checkbox(
                      value: selectedUsers.contains(user),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              selectedUsers.add(user);
                            } else {
                              selectedUsers.remove(user);
                            }
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                slideTransition(const SavedUsers()),
              );
            },
            child: const Text('Go to Saved Users'),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 55.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Tooltip(
              message: 'Add more users',
              child: FloatingActionButton(
                onPressed: fetchUsers,
                child: const Icon(Icons.add),
              ),
            ),
            const SizedBox(width: 15),
            Tooltip(
              message: 'Save',
              child: FloatingActionButton(
                child: const Icon(Icons.save),
                onPressed: () {
                  for (var user in selectedUsers) {
                    saveUser(user);
                  }
        
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved successfully!'), duration: Duration(milliseconds: 500)));
                  
                  Navigator.push(
                    context,
                    slideTransition(const SavedUsers()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void fetchUsers() async {
    final uri = Uri.parse('https://randomuser.me/api/?results=5');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // String body = response.body;
      // print(body);
      final jsonData = jsonDecode(response.body);
      final results = jsonData['results'] as List<dynamic>;
      final converted = results.map((user) {
        return User.fromJson(user);
      }).toList();

      setState(() {
        listOfUsers.addAll(converted);
      });
    }
  }
}


// Function to save user to database
void saveUser(User user) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.saveUser(user);
}


// Function for slide transition
PageRouteBuilder slideTransition(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation1, animation2) => page,
    transitionsBuilder: (context, animation, animationTime, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var slideAnimation = animation.drive(tween);

      return SlideTransition(
        position: slideAnimation,
        child: child,
      );
    },
  );
}

