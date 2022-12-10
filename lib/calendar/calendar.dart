import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/task_model.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime today = DateTime.now();
  DateTime firstDay = DateTime(1990);
  DateTime lastDay = DateTime(2050);

  void _onDaySelected(DateTime day, DateTime focusedDay) =>
      setState(() => today = day);

  String formatDate(DateTime date) => DateFormat("dd MMMM yyyy").format(date);

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> todos = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection("todo")
        .where('date', isEqualTo: formatDate(today))
        .orderBy('start_time');

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                onHeaderTapped: (day) {
                  showDatePicker(
                    context: context,
                    initialDate: today,
                    firstDate: firstDay,
                    lastDate: lastDay,
                    initialDatePickerMode: DatePickerMode.year,
                  ).then((value) {
                    if (value != null) {
                      setState(() => today = value);
                    }
                  });
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    final children = <Widget>[];
                    if (events.isNotEmpty) {
                      children.add(
                        Positioned(
                          right: 1,
                          left: 1,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: kGrey,
                            ),
                            width: 16,
                            height: 16,
                            child: Center(
                              child: Text(
                                events.length.toString(),
                                style: kBodyText,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
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
                            child: CircularProgressIndicator(color: kWhite),
                          );
                        } else if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text(
                                'No Task',
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: kWhite,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                final todo = snapshot.data?.docs[index];
                                Task task = Task(
                                  uid: uid,
                                  id: todo!.id,
                                  name: todo['name'],
                                  date: todo['date'],
                                  startTime: todo['start_time'],
                                  endTime: todo['end_time'],
                                  category: todo['category'],
                                  colorCategory: todo['color_category'],
                                  priority: todo['priority'],
                                  colorPriority: todo['color_priority'],
                                  reminder: todo['reminder'],
                                  notes: todo['notes'],
                                  finished: todo['finished'],
                                );
                                return TodoCard(task: task);
                              },
                            );
                          }
                        } else {
                          return const Text('Gagal Mengambil data!');
                        }
                      },
                    ),
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

class TodoCard extends StatefulWidget {
  final Task task;

  const TodoCard({required this.task, super.key});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    bool finished = widget.task.finished;
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
        onTap: () => Navigator.pushNamed(context, UpdateTaskPage.routeName,
            arguments: widget.task),
        leading: IconButton(
          icon: finished == true
              ? const Icon(Icons.check_circle, color: kPurple, size: 30)
              : const Icon(Icons.circle_outlined, color: kPurple, size: 30),
          onPressed: () {
            finished = !finished;
            FirebaseFirestore.instance
                .collection('users')
                .doc(widget.task.uid)
                .collection("todo")
                .doc(widget.task.id)
                .update({"finished": finished});
          },
        ),
        title: Text(widget.task.name,
            style: kSubtitle, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${widget.task.startTime} - ${widget.task.endTime}',
          style: kBodyText,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
