class Task {
  Task({
    required this.id,
    required this.description,
    required this.isDone,
    required this.taskDate,
  });

  final int id;
  final String description;
  final bool isDone;
  final DateTime taskDate;

  Task copyWith({
    int? id,
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
}
