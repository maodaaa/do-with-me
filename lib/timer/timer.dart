import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../tasks/task_model.dart';

class TimerPage extends StatefulWidget {
  static const routeName = '/timer';

  final Task task;

  const TimerPage({super.key, required this.task});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? countdownTimer;
  late Duration myDuration;

  @override
  void initState() {
    super.initState();
    int hourStart = DateFormat('HH:mm').parse(widget.task.startTime).toLocal().hour;
    int minuteStart = DateFormat('HH:mm').parse(widget.task.startTime).toLocal().minute;
    int hourEnd = DateFormat('HH:mm').parse(widget.task.endTime).toLocal().hour;
    int minuteEnd = DateFormat('HH:mm').parse(widget.task.endTime).toLocal().minute;
    myDuration = Duration(hours: hourEnd-hourStart, minutes: minuteEnd-minuteStart);
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountdown());
  }

  void pauseTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void stopTimer() {
    pauseTimer();
    int hourStart = DateFormat('HH:mm').parse(widget.task.startTime).toLocal().hour;
    int minuteStart = DateFormat('HH:mm').parse(widget.task.startTime).toLocal().minute;
    int hourEnd = DateFormat('HH:mm').parse(widget.task.endTime).toLocal().hour;
    int minuteEnd = DateFormat('HH:mm').parse(widget.task.endTime).toLocal().minute;
    myDuration = Duration(hours: hourEnd-hourStart, minutes: minuteEnd-minuteStart);
    setState(() => myDuration);
  }

  void setCountdown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        taskFinishedNotification(widget.task.name);
        FirebaseFirestore.instance.collection("users").doc(widget.task.uid).collection("todo").doc(widget.task.id).update({
          "finished": true,
        });
        Navigator.pop(context);
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return WillPopScope(
      onWillPop: () async {
        stopTimer();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: const Text(
            'Timer',
            style: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
          ),
          backgroundColor: kPurple,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              stopTimer();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: kWhite),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.task.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                'You have',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '$hours:$minutes:$seconds',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 50
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'before task is finished',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: startTimer,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(15),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                      backgroundColor: MaterialStateProperty.all(kPurple),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Start/Resume',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (countdownTimer == null || countdownTimer!.isActive) {
                        pauseTimer();
                      }
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(15),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                      backgroundColor: MaterialStateProperty.all(kPurple),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Stop/Pause',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ), 
    );
  }
}