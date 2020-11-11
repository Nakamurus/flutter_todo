import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/home/todo_tile.dart';

class TodoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final tasks = Provider.of<List<Todo>>(context) ?? [];

    if (!tasks.isEmpty) {
      tasks.map((e) => e.title != "");
      tasks.sort((a,b) {
        if (a.deadline.day == b.deadline.day) {
          return a.priority.compareTo(b.priority);
        } else {
          return a.deadline.compareTo(b.deadline);
        }
      });
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: tasks[index]);
      }
    );
  }
}