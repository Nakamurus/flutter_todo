

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        'priority': 0,
        'importance': 0,
        'created_at': Timestamp.fromDate(new DateTime.now()),
        'deadline': Timestamp.fromDate(new DateTime.now())
      }])
    });
  }

  Future updateUserData(String name, String title, String detail, int importance, int priority, DateTime deadline) async {

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

  Stream<UserData> get userData {
    return todoCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}