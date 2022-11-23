import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:flutter/material.dart';
import 'todo/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do With Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AddNewTaskPage.routeName,
      routes: {
        ToDoPage.routeName: (context) => const ToDoPage(),
        AddNewTaskPage.routeName: (context) => const AddNewTaskPage(),
        UpdateTaskPage.routeName: (context) => const UpdateTaskPage(),
      },
    );
  }
}