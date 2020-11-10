import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/services/database.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  final _formKey = GlobalKey<FormState>();
  final List<int> priorities = [0, 1, 2, 3, 4, 5];
  final format = DateFormat("yyyy-MM-dd HH:mm");

  String title;
  String detail;
  int importance;
  int priority;
  DateTime createdAt = new DateTime.now();
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
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  items: priorities.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text('$priority priority')
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => priority = val),
                ),
                Slider(
                  value: (importance ?? 100).toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) => setState(() => importance = val.toInt()),
                ),
                SizedBox(height: 20.0),
                DateTimeField(
                  format: format,
                  onShowPicker: (context, curretValue) async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: curretValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                    if (date == null) {
                      deadline = curretValue;
                    } else {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(curretValue ?? DateTime.now())
                      );
                      deadline = DateTimeField.combine(date, time);
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Add task'),
                  onPressed: () async {
                    await DatabaseService(uid: user.uid).updateUserData(
                      userData.name,
                      title,
                      detail,
                      importance,
                      priority,
                      deadline,
                    );
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }
      }
    );
  }
}