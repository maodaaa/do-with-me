import 'package:do_with_me/style/colors.dart';
import 'package:do_with_me/style/text_style.dart';
import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  static const routeName = '/calendar-page';
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  DateTime firstDay = DateTime.utc(2010, 10, 26);
  DateTime lastDay = DateTime.utc(2030, 3, 14);

  void _onDaySelected(DateTime day, DateTime focusedDay) =>
      setState(() => today = day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                locale: "en_US",
                rowHeight: 45,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: kHeading6,
                ),
                firstDay: firstDay,
                lastDay: lastDay,
                focusedDay: today,
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, today),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: kPurple,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Task",
                            style: kHeading6,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pushNamed(
                                context, AddNewTaskPage.routeName),
                            icon: const Icon(Icons.add, size: 24),
                          ),
                        ],
                      ),
                    ),
                    const TaskCard(
                        taskName: 'Mengerjakan Tugas', time: '10:00 - 12:00'),
                    const TaskCard(
                        taskName: 'Mengerjakan Tugas', time: '10:00 - 12:00'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String taskName;
  final String time;

  const TaskCard({required this.taskName, required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width - 30,
      decoration: const BoxDecoration(
          color: kSoftGrey,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, UpdateTaskPage.routeName),
        title: Text(taskName),
        subtitle: Text(time),
      ),
    );
  }
}
