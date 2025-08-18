import 'package:flutter/material.dart';
import 'package:to_do_firebase/models/task.dart';
import 'package:to_do_firebase/utils/db_util.dart';
import 'package:uuid/uuid.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  Future<void> loadTasks() async {
    final dataList = await DbUtil.getData('tasks');

    _tasks = dataList
        .map(
          (task) => Task(
            id: task['id'],
            description: task['description'],
            isDone: getIsDoneBool(task['isDone']),
            taskDate: DateTime.fromMillisecondsSinceEpoch(task['taskDate']),
          ),
        )
        .toList();

    notifyListeners();
  }

  List<Task> get tasks {
    return [..._tasks];
  }

  int get itemsCount {
    return _tasks.length;
  }

  bool getIsDoneBool(int value) {
    return value != 0 ? true : false;
  }

  Future<bool> addTask(String description, bool isDone, DateTime taskDate) async {
    final newTask = Task(id: Uuid().v4(), description: description, isDone: isDone, taskDate: taskDate);

    try {
      await DbUtil.insert('tasks', {
        'id': newTask.id,
        'description': newTask.description,
        'isDone': newTask.isDoneAsInt,
        'taskDate': newTask.taskDate.millisecondsSinceEpoch,
      });
      _tasks.add(newTask);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }

  //void toggleTask(int id, bool isDone) {
  //  final index = _tasks.indexWhere((t) => t.id == id);
  //  if (index != -1) {
  //    _tasks[index] = _tasks[index].copyWith(isDone: isDone);
  //    notifyListeners();
  //  }
  //}

  Future<bool> deleteTask(String id) async {
    try {
      await DbUtil.deleteId('tasks', id);
      _tasks.removeWhere((t) => t.id == id);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
}
