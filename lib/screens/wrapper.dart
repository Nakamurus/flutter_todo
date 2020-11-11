import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/screens/authenticate/authenticate.dart';
import 'package:todo_app/screens/home/home.dart';
import 'package:todo_app/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home(user: user);
    }
  }
}