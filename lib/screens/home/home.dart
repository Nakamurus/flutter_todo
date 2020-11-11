import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/home/create_task.dart';
import 'package:todo_app/screens/home/todo_list.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.75,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: CreateTask(),
        );
      });
    }

    return StreamProvider<List<Todo>>.value(
      value: DatabaseService().collection,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo Service'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Add tasks'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: TodoList(),
      ),
    );
  }
}