import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/tasks/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateTaskPage extends StatefulWidget {
  static const routeName = '/updateTodo';

  final Task task;

  const UpdateTaskPage({super.key, required this.task});

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController sTimeController = TextEditingController();
  TextEditingController eTimeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    taskController.text = widget.task.name;
    dateController.text = widget.task.date;
    sTimeController.text = widget.task.startTime;
    eTimeController.text = widget.task.endTime;
    categoryController.text = widget.task.category;
    priorityController.text = widget.task.priority;
    reminderController.text = widget.task.reminder;
    notesController.text = widget.task.notes;
    super.initState();
  }

  @override
  void dispose() {
    taskController.dispose();
    dateController.dispose();
    sTimeController.dispose();
    eTimeController.dispose();
    categoryController.dispose();
    priorityController.dispose();
    reminderController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void updateTask() {
    final taskId = widget.task.id;
    final uid = widget.task.uid;
    var colorCategory = "";
    var colorPriority = "";

    if (categoryController.text == "School") {
      colorCategory = kRedCategory.toString();
    } else if (categoryController.text == "Work") {
      colorCategory = kYellowCategory.toString();
    } else if (categoryController.text == "Sport") {
      colorCategory = kGreenCategory.toString();
    } else if (categoryController.text == "Meditation") {
      colorCategory = kBrownCategory.toString();
    }

    if (priorityController.text == "High") {
      colorPriority = kHighPriority.toString();
    } else if (priorityController.text == "Normal") {
      colorPriority = kNormalPriority.toString();
    } else if (priorityController.text == "Low") {
      colorPriority = kLowPriority.toString();
    }
    FirebaseFirestore.instance.collection("users").doc(uid).collection("todo").doc(taskId).update({
      "name": taskController.text,
      "date": dateController.text,
      "start_time": sTimeController.text,
      "end_time": eTimeController.text,
      "category": categoryController.text,
      "color_category": colorCategory,
      "priority": priorityController.text,
      "color_priority": colorPriority,
      "reminder": reminderController.text,
      "notes": notesController.text,
      "finished": widget.task.finished,
    });
    // FirebaseFirestore.instance.collection('todos').doc(taskName).delete();

    // FirebaseFirestore.instance.collection("todos").doc(taskNameChanged).update({
    //   "name": taskNameChanged,
    //   "date": dateController.text,
    //   "start_time": sTimeController.text,
    //   "end_time": eTimeController.text,
    //   "category": categoryController.text,
    //   "color_category": colorCategory,
    //   "priority": priorityController.text,
    //   "color_priority": colorPriority,
    //   "reminder": reminderController.text,
    //   "notes": notesController.text,
    // });
  }

  void deleteTask(String taskId) {
    final uid = widget.task.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).collection("todo").doc(taskId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final taskId = widget.task.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Task',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: taskController,
                  obscureText: false,
                  style: kBodyText,
                  decoration: InputDecoration(
                    labelText: 'What\'s your task?',
                    labelStyle: kSubtitle.copyWith(color: kBlack),
                    hintStyle: kBodyText.copyWith(color: kBlack),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(16),
                child: TextField(
                  controller: dateController,
                  obscureText: false,
                  style: kBodyText,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: kSubtitle.copyWith(color: kBlack),
                    hintStyle: kBodyText.copyWith(color: kBlack),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate = DateFormat('dd MMMM yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateController.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: TextField(
                        controller: sTimeController,
                        obscureText: false,
                        style: kBodyText,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          labelStyle: kSubtitle.copyWith(color: kBlack),
                          hintStyle: kBodyText.copyWith(color: kBlack),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF1F4F8),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPurple,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                          prefixIcon: const Icon(Icons.alarm),
                        ),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context));
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            print(parsedTime);
                            String formattedTime = DateFormat('HH:mm').format(parsedTime);
                            print(formattedTime);

                            setState(() {
                              sTimeController.text = formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: TextField(
                          controller: eTimeController,
                          obscureText: false,
                          style: kBodyText,
                          decoration: InputDecoration(
                            labelText: 'End Time',
                            labelStyle: kSubtitle.copyWith(color: kBlack),
                            hintStyle: kBodyText.copyWith(color: kBlack),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF1F4F8),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kPurple,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                            prefixIcon: const Icon(Icons.alarm),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(pickedTime.format(context));
                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                              print(parsedTime);
                              String formattedTime = DateFormat('HH:mm').format(parsedTime);
                              print(formattedTime);

                              setState(() {
                                eTimeController.text = formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  value: categoryController.text,
                  style: kBodyText,
                  items: <String>["School", "Work", "Sport", "Meditation"]
                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                            value: value,
                            child: Text(value == "School"
                                ? "School"
                                : value == "Work"
                                    ? "Work"
                                    : value == "Sport"
                                      ? "Sport"
                                      : "Meditation"),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      categoryController.text = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: kSubtitle.copyWith(color: kBlack),
                    hintStyle: kBodyText.copyWith(color: kBlack),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                    prefixIcon: Icon(
                      Icons.circle,
                      color: categoryController.text == "School"
                          ? kRedCategory
                          : categoryController.text == "Work"
                              ? kYellowCategory
                              : categoryController.text == "Sport"
                                ? kGreenCategory
                                : kBrownCategory,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  value: priorityController.text,
                  style: kBodyText,
                  items: <String>["High", "Normal", "Low"]
                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                            value: value,
                            child: Text(value == "High"
                                ? "High"
                                : value == "Normal"
                                    ? "Normal"
                                    : "Low"),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      priorityController.text = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    labelStyle: kSubtitle.copyWith(color: kBlack),
                    hintStyle: kBodyText.copyWith(color: kBlack),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                    prefixIcon: Icon(
                      Icons.circle,
                      color: priorityController.text == "High"
                          ? kHighPriority
                          : priorityController.text == "Normal"
                              ? kNormalPriority
                              : kLowPriority,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  value: reminderController.text,
                  style: kBodyText,
                  items: <String>[
                    "5 minutes before",
                    "10 minutes before",
                    "15 minutes before",
                    "30 minutes before",
                    "1 hour before",
                  ]
                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                            value: value,
                            child: Text(value == "5 minutes before"
                                ? "5 minutes before"
                                : value == "10 minutes before"
                                    ? "10 minutes before"
                                    : value == "15 minutes before"
                                        ? "15 minutes before"
                                        : value == "30 minutes before"
                                            ? "30 minutes before"
                                            : "1 hour before"),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      reminderController.text = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Reminder',
                    labelStyle: kSubtitle.copyWith(color: kBlack),
                    hintStyle: kBodyText.copyWith(color: kBlack),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: notesController,
                  obscureText: false,
                  style: kBodyText,
                  decoration: InputDecoration(
                    labelText: 'Notes',
                    labelStyle: kSubtitle.copyWith(color: kBlack),
                    hintStyle: kBodyText.copyWith(color: kBlack),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                  ),
                  minLines: 5,
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      updateTask();
                      Navigator.pop(context);
                      print('Task Updated');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPurple,
                      textStyle: kHeading6,
                    ),
                    child: const Text('Update Task'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      deleteTask(taskId);
                      Navigator.pop(context);
                      print('Task Deleted');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kRedCategory,
                      textStyle: kHeading6,
                    ),
                    child: const Text('Delete Task'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
