import 'package:flutter/material.dart';
import 'package:todo_app/screen/home/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
        ),
        body: TodoList(),
      ),
    );
  }
}