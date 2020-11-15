import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/home/todo_tile.dart';
import 'package:todo_app/services/database.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {

    final tasks = Provider.of<List<Todo>>(context) ?? [];

    List<Todo> filtered = [];

    if (tasks.length >= 1) {
      filtered = tasks.where((task) => !task.deleted).toList();
      filtered.sort((a,b) {
        if (a.deadline.day == b.deadline.day) {
          return a.priority.compareTo(b.priority);
        } else {
          return a.deadline.compareTo(b.deadline);
        }
      });
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(color: Colors.red),
          key: Key(filtered[index].taskId),
          child: TodoTile(todo: filtered[index]),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return  AlertDialog(
                  title: Text('Confirm'),
                  content: Text('Are you sure you want to delete this item?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Delete'),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    )
                  ],
                );
              }
            );
          },
          onDismissed: (direction) {
            setState(() => {
              filtered.removeAt(index)
            });
            DatabaseService(uid: filtered[index].uid).deleteTaskFromUserData(filtered[index].taskId);
          },
        );
      }
    );
  }
}