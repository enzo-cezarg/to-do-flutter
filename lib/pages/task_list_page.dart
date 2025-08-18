import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_firebase/components/task_list.dart';
import 'package:to_do_firebase/providers/task_provider.dart';
import 'package:to_do_firebase/providers/theme_provider.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Consumer<ThemeProvider>(
      builder: (ctx, theme, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: theme.currentColorScheme.primary,
          foregroundColor: theme.currentColorScheme.onPrimary,
          title: Text('Tasks'),
          actions: [IconButton(onPressed: theme.toggleTheme, icon: theme.currentThemeIcon)],
        ),
        body: TaskList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final bool added = await taskProvider.addTask('tarefa teste', false, DateTime.now());
            if (!context.mounted) return;

            final messenger = ScaffoldMessenger.of(context);
            messenger.clearSnackBars();
            added
                ? messenger.showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                      content: Text(
                        'Added.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : messenger.showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      duration: Duration(seconds: 2),
                      content: Text(
                        'Something went wrong.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
