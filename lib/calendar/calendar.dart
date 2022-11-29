import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/style/colors.dart';
import 'package:do_with_me/style/text_style.dart';
import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  static const routeName = '/calendar-page';
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  DateTime firstDay = DateTime(1990);
  DateTime lastDay = DateTime(2050);

  void _onDaySelected(DateTime day, DateTime focusedDay) =>
      setState(() => today = day);

  String formatDate(DateTime date) => DateFormat("dd MMMM yyyy").format(date);

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> todos = FirebaseFirestore.instance
        .collection('todos')
        .where('date', isEqualTo: formatDate(today))
        .orderBy('start_time');

    return Scaffold(
      body: SafeArea(
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
              calendarStyle: CalendarStyle(
                defaultTextStyle: kBodyText,
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
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: kPurple,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(80, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, -1),
                    ),
                  ],
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
                            style: GoogleFonts.inter(
                              color: kWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AddNewTaskPage.routeName,
                            ),
                            icon:
                                const Icon(Icons.add, size: 24, color: kWhite),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: todos.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              final todo = snapshot.data?.docs[index];
                              return TodoCard(
                                name: todo!['name'],
                                startTime: todo['start_time'],
                                endTime: todo['end_time'],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Text('Gagal Mengambil data!');
                        } else {
                          return const Text('Kamu tidak memiliki Tugas!');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final String name;
  final String startTime;
  final String endTime;

  const TodoCard({
    required this.name,
    required this.startTime,
    required this.endTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: MediaQuery.of(context).size.width - 30,
      decoration: const BoxDecoration(
        color: kSoftGrey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(80, 0, 0, 0),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, UpdateTaskPage.routeName),
        title: Text(name),
        subtitle: Text('$startTime - $endTime'),
      ),
    );
  }
}
