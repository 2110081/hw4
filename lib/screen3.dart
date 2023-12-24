import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'models.dart';


class SavedUsers extends StatefulWidget {
  const SavedUsers({super.key});

  @override
  State<SavedUsers> createState() => _SavedUsersState();
}

class _SavedUsersState extends State<SavedUsers> {
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Users'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<User>>(
              future: dbHelper.getUsers(),
              builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = snapshot.data![index];
                      return ListTile(
                        title: Text('${user.name!.first} ${user.name!.last}'),
                        subtitle: Text(user.email),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}