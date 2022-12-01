import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  DateTime firstDay = DateTime.utc(2010, 10, 26);
  DateTime lastDay = DateTime.utc(2030, 3, 14);

  void _onDaySelected(DateTime day, DateTime focusedDay) => setState(() => today = day);

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
                            onPressed: () {},
                            icon: const Icon(Icons.add, size: 24),
                          ),
                        ],
                      ),
                    ),
                    const TaskCard(),
                    const TaskCard(),
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
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width - 30,
      height: 70,
      decoration: const BoxDecoration(color: kSoftGrey, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Mengerjakan Project",
              style: kSubtitle,
            ),
            Text(
              "09:00 - 12:00",
              style: kBodyText,
            ),
          ],
        ),
      ),
    );
  }
}
