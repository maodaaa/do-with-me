import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:do_with_me/profil/profil.dart';
import 'package:do_with_me/todo/todo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'calendar/calendar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: ProfilPage.routeName,
      routes: {
        ToDoPage.routeName: (context) => const ToDoPage(),
        AddNewTaskPage.routeName: (context) => const AddNewTaskPage(),
        UpdateTaskPage.routeName: (context) => const UpdateTaskPage(),
        CalendarPage.routeName: (context) => const CalendarPage(),
        ProfilPage.routeName: (context) => const ProfilPage(),
      },
      home: const CalendarPage(),
    );
  }
}
