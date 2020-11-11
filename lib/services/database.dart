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

  Future updateUserData(String title, String detail, String priority, int importance, DateTime deadline) async {

    return todoCollection.doc(uid).update({
      'tasks': FieldValue.arrayUnion([{
        'title': title,
        'detail': detail,
        'priority': priority,
        'importance': importance,
        'created_at': Timestamp.fromDate(new DateTime.now()),
        'deadline': Timestamp.fromDate(deadline)
      }]),
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    // snapshot.data()['tasks'].map((e) => e.title == )
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

  List<Todo> _todoListFromSnapshot(DocumentSnapshot snapshot) {
    final List<Todo> collection = [];
    snapshot.data()['tasks'].forEach((result) {
      collection.add(Todo(
        name: snapshot.data()['user_name'],
        title: result['title'] ?? '',
        detail: result['detail'] ?? '',
        priority: result['priority'] ?? '0',
        importance: result['importance'] ?? 0,
        createdAt: result['createdAt']?.toDate() ?? DateTime.now(),
        deadline: result['deadline']?.toDate() ?? DateTime.now().add(Duration(days: 7)),
      ));
    });
    return collection;
  }

  Stream<List<Todo>> get collection {
    return todoCollection.doc(uid).snapshots()
      .map(_todoListFromSnapshot);
  }
}