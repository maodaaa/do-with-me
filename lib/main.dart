import 'package:do_with_me/home_screen/home_screen.dart';
import 'package:do_with_me/login_screen/signin_screen.dart';
import 'package:do_with_me/login_screen/signup_screen.dart';
import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/task_model.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:do_with_me/todo/todo_page.dart';
import 'package:do_with_me/profil/profil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => const SignInScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ToDoPage.routeName: (context) => const ToDoPage(),
        AddNewTaskPage.routeName: (context) => const AddNewTaskPage(),
        UpdateTaskPage.routeName: (context) => UpdateTaskPage(
              task: ModalRoute.of(context)!.settings.arguments as Task,
            ),
        CalendarPage.routeName: (context) => const CalendarPage(),
        ProfilPage.routeName: (context) => const ProfilPage(),
      },
      home: const SignInScreen(),
    );
  }
}
