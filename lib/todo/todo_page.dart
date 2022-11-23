import 'package:do_with_me/style/colors.dart';
import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ToDoPage extends StatefulWidget {
  static const routeName = '/to-do';

  const ToDoPage({super.key});

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime focusDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime firstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  DateTime lastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        focusDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurple,
      body: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 24),
              const Icon(
                Icons.calendar_month, 
                size: 40,
                color: kWhite,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.MMMM().format(focusDay),
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                  Text(
                    DateFormat.y().format(focusDay),
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: kWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), 
                  topRight: Radius.circular(20)
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: TableCalendar(
                      calendarStyle: const CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: kPurple,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: kSoftBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerVisible: false,
                      availableGestures: AvailableGestures.none,
                      firstDay: firstDay,
                      lastDay: lastDay,
                      focusedDay: focusDay,
                      onDaySelected: _onDaySelected,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Tasks',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: const Icon(Icons.add, size: 36),
                          onPressed: () {
                            Navigator.pushNamed(context, AddNewTaskPage.routeName);
                          }
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TaskCard(name: 'Mengerjakan Project', time: '09:00 - 12:00'),
                  TaskCard(name: 'Bikin UI/Design', time: '12:00 - 14:00'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  String name;
  String time;

  TaskCard({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: kGrey,
        border: Border.all(),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, UpdateTaskPage.routeName);
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(Icons.circle_outlined, color: kPurple),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(time),
          ],
        ),
        trailing: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.circle, color: Colors.red)
        ),
      ),
    );
  }
}