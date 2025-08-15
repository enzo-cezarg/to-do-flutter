import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_firebase/components/task_widget.dart';
import 'package:to_do_firebase/providers/task_provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskWidget(task: tasks[index]);
        },
      ),
    );
  }
}
