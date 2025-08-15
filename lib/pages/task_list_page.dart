import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_firebase/components/task_list.dart';
import 'package:to_do_firebase/providers/theme_provider.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
