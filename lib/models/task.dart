class Task {
  Task({
    required this.id,
    required this.description,
    required this.isDone,
    required this.taskDate,
  });

  final String id;
  final String description;
  bool isDone;
  final DateTime taskDate;

  Task copyWith({
    String? id,
    String? description,
    bool? isDone,
    DateTime? taskDate,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      taskDate: taskDate ?? this.taskDate,
    );
  }

  int get isDoneAsInt => isDone ? 1 : 0;
}
