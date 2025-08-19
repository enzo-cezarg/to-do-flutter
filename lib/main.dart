import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_firebase/pages/task_list_page.dart';
import 'package:to_do_firebase/providers/task_provider.dart';
import 'package:to_do_firebase/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isLightMode = prefs.getBool('isLightMode') ?? true;

  runApp(MyApp(isLightMode: isLightMode, prefs: prefs));
}

class MyApp extends StatelessWidget {
  final bool isLightMode;
  final SharedPreferences prefs;

  const MyApp({super.key, required this.isLightMode, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(initialIsLight: isLightMode, prefs: prefs)),
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
