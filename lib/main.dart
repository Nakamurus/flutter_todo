import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/screens/authenticate/register.dart';
import 'package:todo_app/screens/authenticate/sign_in.dart';
import 'package:todo_app/screens/home/create_task.dart';
import 'package:todo_app/screens/home/todo_list.dart';
import 'package:todo_app/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Scaffold(
          body: CreateTask(),
        )
      ),
    );
  }
}