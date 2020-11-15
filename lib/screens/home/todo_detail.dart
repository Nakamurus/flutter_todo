import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class TodoDetail extends StatelessWidget {

  final Todo todo;
  TodoDetail({ this.todo });


  final double subtitleSize = 15.0;
  final double titleSize = 30.0;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white.withOpacity(0.5),
      constraints: BoxConstraints.expand(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 300.0),
              child: Container(
                decoration: new BoxDecoration(
                color: Colors.orange[50],
                borderRadius: new BorderRadius.circular(25.0)
                ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 30.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: titleSize
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text('Deadline:${todo.deadline.year.toString()}年${todo.deadline.month.toString()}月${todo.deadline.day.toString()}日${todo.deadline.hour.toString()}時${todo.deadline.minute.toString()}分',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: subtitleSize
                        ),
                      ),
                    ),
                    Text(
                      todo.detail,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: titleSize
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.bottomRight,
                    //   padding: EdgeInsets.all(5.0),
                    //   child: todo.name.isNotEmpty ? Text(
                    //     'Created By ${todo.name}',
                    //     style: TextStyle(
                    //       color: Colors.black54,
                    //       fontSize: subtitleSize
                    //     ),
                    //   ) : Container()
                    // ),
                    Spacer(),
                    FlatButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text('Delete this task'),
                      onPressed: () async {
                        print(todo.uid);
                        DatabaseService(uid: todo.uid).deleteTaskFromUserData(todo.taskId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )
            )
          ),
        )
      ),
    );
  }
}