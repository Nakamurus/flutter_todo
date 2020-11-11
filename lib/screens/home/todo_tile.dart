import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/home/todo_detail.dart';

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
            backgroundColor: Colors.brown[todo.importance],
          ),
          title: Text(todo.title),
          // TODO replace manual translation to package-based automatical one, like intl.
          subtitle: Text('Deadline: ${todo.deadline.year.toString()}年${todo.deadline.month.toString()}月${todo.deadline.day.toString()}日${todo.deadline.hour.toString()}時${todo.deadline.minute.toString()}分'),
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