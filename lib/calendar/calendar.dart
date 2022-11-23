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
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
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
                  color: Color.fromARGB(255, 151, 208, 255),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Task",
                            style: TextStyle(fontSize: 24),
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
      decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Mengerjakan Project",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "09:00 - 12:00",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
