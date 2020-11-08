import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoDetail extends StatelessWidget {

  final Todo todo;

  TodoDetail({ this.todo });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)
        ),
        child: Center(
          child: Text(todo.detail)
        )
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}