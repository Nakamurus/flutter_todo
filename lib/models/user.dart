class CustomUser {
  final String uid;

  CustomUser({ this. uid });
}

class UserData {
  final String uid;
  final String name;
  final String title;
  final String detail;
  final int priority;
  final int importance;
  final DateTime createdAt;
  final DateTime deadline;

  UserData({ this.uid, this.name, this.title, this.detail, this.priority, this.importance, this.createdAt, this.deadline });
}