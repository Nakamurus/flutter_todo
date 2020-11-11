import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';

class TodoDetail extends StatelessWidget {

  final Todo todo;
  TodoDetail({ this.todo });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 100.0
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.red[todo.importance],
                      ),
                      Text(
                        todo.deadline.toString(),
                        style: TextStyle(
                          color: Colors.black54
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  todo.detail,
                  style: TextStyle(
                    color: Colors.black54
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'By ${todo.name}',
                  )
                )
              ],
            )
          )
        )
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}