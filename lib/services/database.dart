import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  final CollectionReference todoCollection = FirebaseFirestore.instance.collection('tasks');

  Future registerUserData(String name) async {
    return todoCollection.doc(uid).set({
      'user_name': name,
      'tasks': FieldValue.arrayUnion([{
        'title': '',
        'detail': '',
        'priority': '0',
        'importance': 0,
        'created_at': Timestamp.fromDate(new DateTime.now()),
        'deadline': Timestamp.fromDate(new DateTime.now())
      }])
    });
  }

  Future updateUserData(String name, String title, String detail, String importance, int priority, DateTime deadline) async {

    return todoCollection.doc(uid).update({
      'user_name': name,
      'tasks': FieldValue.arrayUnion([{
        'title': title,
        'detail': detail,
        'priority': priority,
        'importance': importance,
        'created_at': Timestamp.fromDate(new DateTime.now()),
        'deadline': Timestamp.fromDate(deadline)
      }])
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['user_name'],
      title: snapshot.data()['title'],
      detail: snapshot.data()['detail'],
      importance: snapshot.data()['importance'],
      priority: snapshot.data()['priority'],
      createdAt: snapshot.data()['createdAt'],
      deadline: snapshot.data()['deadline'],
    );
  }

  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((snapshot) {
      return Todo(
        name: snapshot.data()['user_name'] ?? '',
        title: snapshot.data()['title'] ?? '',
        detail: snapshot.data()['detail'] ?? '',
        priority: snapshot.data()['priority'] ?? '0',
        importance: snapshot.data()['importance'] ?? 0,
        createdAt: snapshot.data()['createdAt'] ?? DateTime.now(),
        deadline: snapshot.data()['deadline'] ?? DateTime.now().add(Duration(days: 7)),
      );
    }).toList();
  }

  Stream<List<Todo>> get collection {
    return todoCollection.snapshots()
      .map(_todoListFromSnapshot);
  }

  Stream<UserData> get userData {
    return todoCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}