import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  final CollectionReference todoCollection = FirebaseFirestore.instance.collection('tasks');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future registerUserData(String name) async {
    return userCollection.doc(uid).set({
      'user_name': name,
    });
  }

  Future addTaskToUserData(String taskId) async {
    return userCollection.doc(uid).update({
      'tasks': FieldValue.arrayUnion([{
        'taskId': taskId
      }])
    });
  }

  Future deleteTaskFromUserData(String taskId) async {
    print(uid);
    print(taskId);
    try {
      await todoCollection.doc(taskId).update({
        'deleted': true
      });
      return userCollection.doc(uid).update({
        'tasks': FieldValue.arrayRemove([{
          'taskId': taskId
        }])
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addTaskData(String title, String detail, String priority, int importance, DateTime deadline) async {
    final String _taskId = todoCollection.doc().id;
    await addTaskToUserData(_taskId);
    return todoCollection.doc(_taskId).set({
      'uid': uid,
      'taskId': _taskId,
      'title': title,
      'detail': detail,
      'priority': priority,
      'importance': importance,
      'created_at': Timestamp.fromDate(new DateTime.now()),
      'deadline': Timestamp.fromDate(deadline)
    });
  }

  Future updateTaskData(String taskId, String title, String detail, String priority, int importance, DateTime deadline) async {
    return todoCollection.doc(taskId).update({
      'uid': uid,
      'taskId': taskId,
      'title': title,
      'detail': detail,
      'priority': priority,
      'importance': importance,
      'deadline': Timestamp.fromDate(deadline)
    });
  }

  Future deleteUserData() async {
    try {
      return userCollection.doc(uid).delete();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  UserData _taskDataFromSnapshot(DocumentSnapshot snapshot) {
    // snapshot.data()['tasks'].map((e) => e.title == )
    return UserData(
      uid: uid,
      title: snapshot.data()['title'],
      detail: snapshot.data()['detail'],
      importance: snapshot.data()['importance'],
      priority: snapshot.data()['priority'],
      createdAt: snapshot.data()['createdAt'],
      deadline: snapshot.data()['deadline'],
    );
  }

  List<Todo> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
        uid: doc.data()['uid'],
        taskId: doc.data()['taskId'],
        title: doc.data()['title'] ?? '',
        detail: doc.data()['detail'] ?? '',
        priority: doc.data()['priority'] ?? '0',
        importance: doc.data()['importance'] ?? 0,
        createdAt: doc.data()['createdAt']?.toDate() ?? DateTime.now(),
        deadline: doc.data()['deadline']?.toDate() ?? DateTime.now().add(Duration(days: 7)),
        deleted: doc.data()['deleted'] ?? false
      );
    }).toList();
  }

  // TODO create Stream<Todo> to update a task.

  Stream<List<Todo>> get collection {
    return todoCollection.snapshots()
      .map(_taskListFromSnapshot);
  }
}