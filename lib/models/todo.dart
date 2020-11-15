class Todo {

  final String uid;
  final String taskId;
  final String title;
  final String detail;
  final String priority;
  final int importance;
  final DateTime createdAt;
  final DateTime deadline;
  final bool deleted;

  Todo({ this.uid, this.taskId, this.title, this.detail, this.priority, this.importance, this.createdAt, this.deadline, this.deleted });
}