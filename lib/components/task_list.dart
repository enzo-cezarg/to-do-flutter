import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_firebase/components/task_widget.dart';
import 'package:to_do_firebase/providers/task_provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: Provider.of<TaskProvider>(context, listen: false).loadTasks(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<TaskProvider>(
                builder: (ctx, taskProvider, child) => taskProvider.itemsCount == 0
                    ? child!
                    : ListView.builder(
                        itemCount: taskProvider.itemsCount,
                        itemBuilder: (context, index) {
                          return TaskWidget(task: taskProvider.tasks[index]);
                        },
                      ),
                child: Text('No tasks.'),
              ),
      ),
    );
  }
}
