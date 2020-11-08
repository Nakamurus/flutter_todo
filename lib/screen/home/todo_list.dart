import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screen/home/todo_tile.dart';

class TodoList extends StatelessWidget {

  final todos = List<Todo>.generate(9, (i) => Todo(
    priority: (i+1)*100,
    detail: 'Todo'
    )
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: todos[index]);
      }
    );
  }
}