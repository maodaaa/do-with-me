import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/tasks/add_task_page.dart';
import 'package:do_with_me/tasks/task_model.dart';
import 'package:do_with_me/tasks/update_task_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ToDoPage extends StatefulWidget {
  static const routeName = '/to-do';

  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime focusDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime firstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  DateTime lastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    _selectedDay = focusDay;
  }

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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                            }),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .collection("todo")
                              .where('date', isEqualTo: DateFormat('dd MMMM yyyy').format(_selectedDay!))
                              .orderBy('start_time', descending: false)
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                'Something went wrong',
                                style: kHeading6Normal,
                              );
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text(
                                'Loading',
                                style: kHeading6Normal,
                              );
                            }
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No Tasks',
                                    style: kHeading6Normal,
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No Tasks',
                                      style: kHeading6Normal,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    return TaskCard(
                                      uid: uid,
                                      id: snapshot.data!.docs[index].id,
                                      name: snapshot.data?.docs[index]['name'],
                                      date: snapshot.data?.docs[index]['date'],
                                      sTime: snapshot.data?.docs[index]['start_time'],
                                      eTime: snapshot.data?.docs[index]['end_time'],
                                      category: snapshot.data?.docs[index]['category'],
                                      colorCategory: snapshot.data?.docs[index]['color_category'],
                                      priority: snapshot.data?.docs[index]['priority'],
                                      colorPriority: snapshot.data?.docs[index]['color_priority'],
                                      reminder: snapshot.data?.docs[index]['reminder'],
                                      notes: snapshot.data?.docs[index]['notes'],
                                      finished: snapshot.data?.docs[index]['finished'],
                                    );
                                  }),
                                );
                              }
                            }
                            return Container();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  String uid;
  String id;
  String name;
  String date;
  String sTime;
  String eTime;
  String category;
  String colorCategory;
  String priority;
  String colorPriority;
  String reminder;
  String notes;
  bool finished;

  TaskCard({
    super.key,
    required this.uid,
    required this.id,
    required this.name,
    required this.date,
    required this.sTime,
    required this.eTime,
    required this.category,
    required this.colorCategory,
    required this.priority,
    required this.colorPriority,
    required this.reminder,
    required this.notes,
    required this.finished,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    String valueString = widget.colorCategory.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Slidable(
        endActionPane: ActionPane(extentRatio: 0.45, motion: const DrawerMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) {
              Navigator.pushNamed(context, UpdateTaskPage.routeName,
                  arguments: Task(
                    uid: widget.uid,
                    id: widget.id,
                    name: widget.name,
                    date: widget.date,
                    startTime: widget.sTime,
                    endTime: widget.eTime,
                    category: widget.category,
                    colorCategory: widget.colorCategory,
                    priority: widget.priority,
                    colorPriority: widget.colorPriority,
                    reminder: widget.reminder,
                    notes: widget.notes,
                    finished: widget.finished,
                  ));
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: 'Update',
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) {
              FirebaseFirestore.instance.collection("users").doc(widget.uid).collection("todo").doc(widget.id).delete();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: Container(
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
              setState(() {
                widget.finished = !widget.finished;
              });
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.uid)
                  .collection("todo")
                  .doc(widget.id)
                  .update({'finished': widget.finished});
            },
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: widget.finished
                  ? const Icon(Icons.check_circle, color: kPurple)
                  : const Icon(Icons.circle_outlined, color: kPurple),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: kBodyText),
                Text('${widget.sTime} - ${widget.eTime}', style: kBodyText),
              ],
            ),
            trailing: Padding(padding: const EdgeInsets.only(right: 10), child: Icon(Icons.circle, color: otherColor)),
          ),
        ),
      ),
    );
  }
}
