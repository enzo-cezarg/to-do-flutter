import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_firebase/models/task.dart';
import 'package:to_do_firebase/providers/task_provider.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (_) {
        Task removedTask = task;
        taskProvider.deleteTask(task.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: Text(
              'Item removed',
              style: TextStyle(color: onPrimaryColor),
            ),
            action: SnackBarAction(
              label: 'UNDO',
              textColor: onPrimaryColor,
              onPressed: () {
                taskProvider.addTask(removedTask.description, removedTask.isDone, removedTask.taskDate);
              },
            ),
            duration: Duration(seconds: 3),
          ),
        );
      },
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 15,
                decoration: BoxDecoration(
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 4),
                      blurRadius: 30,
                      blurStyle: BlurStyle.inner,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 8, top: 8, right: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      task.description,
                      style: task.isDone
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(task.taskDate),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    trailing: Checkbox(
                      value: task.isDone,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      onChanged: (v) => {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
