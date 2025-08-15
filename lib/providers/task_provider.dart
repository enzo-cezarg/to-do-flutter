import 'package:flutter/material.dart';
import 'package:to_do_firebase/models/task.dart';

class TaskProvider with ChangeNotifier {
  final _tasks = <Task>[
    Task(id: 1, description: 'Tarefa 1', taskDate: DateTime.parse('1969-08-08 20:00:00'), isDone: false),
    Task(id: 2, description: 'Tarefa 2', taskDate: DateTime.parse('1969-08-08 20:00:00'), isDone: false),
  ];

  List<Task> get tasks {
    List<Task> orderedTasks = [..._tasks];

    orderedTasks.sort(
      (a, b) => a.id.compareTo(b.id),
    );

    return orderedTasks;
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(int id, bool isDone) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(isDone: isDone);
      notifyListeners();
    }
  }

  void deleteTask(int id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
