class Todo {
  final String id;
  final String task;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.task,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      task: json['task'],
      isCompleted: json['isCompleted'],
    );
  }
}
