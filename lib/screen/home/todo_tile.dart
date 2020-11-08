import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screen/home/todo_detail.dart';

class TodoTile extends StatelessWidget {

  final Todo todo;
  TodoTile({ this.todo });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 6.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[todo.priority],
          ),
          title: Text('Todo'),
          subtitle: Text('Priority ${todo.priority}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return TodoDetail(todo: todo);
              })
            );
          },
        ),
      ),
    );
  }
}