import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_firebase/pages/task_list_page.dart';
import 'package:to_do_firebase/providers/task_provider.dart';
import 'package:to_do_firebase/providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, theme, child) => MaterialApp(
          title: 'To-do List',
          theme: ThemeData(
            colorScheme: theme.currentColorScheme,
            useMaterial3: true,
          ),
          home: const TaskListPage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
