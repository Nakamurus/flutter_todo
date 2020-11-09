import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/services/database.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  final _formKey = GlobalKey<FormState>();

  String title;
  String detail;
  int importance;
  int priority;
  DateTime createdAt;
  DateTime deadline;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Add your task'
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) => setState(() => title = val)
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) => setState(() => detail = val)
                ),
              ],
            ),
          );
        }
      }
    );
  }
}