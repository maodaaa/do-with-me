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
      title: 'To Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoPage(),
    );
  }
}