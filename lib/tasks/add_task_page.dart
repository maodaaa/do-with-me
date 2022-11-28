import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../style/colors.dart';
import '../style/text_style.dart';

class AddNewTaskPage extends StatefulWidget {
  static const routeName = '/add-task';
  
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
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
    taskController.text = "";
    dateController.text = "";
    sTimeController.text = "";
    eTimeController.text = "";
    categoryController.text = "Education";
    priorityController.text = "High";
    reminderController.text = "5 minutes before";
    notesController.text = "";
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

  void addTask() {
    final taskName = taskController.text;
    var colorCategory = "";
    var colorPriority = "";
    
    if(categoryController.text == "Education") {
      colorCategory = kRedCategory.toString();
    } else if(categoryController.text == "Work") {
      colorCategory = kYellowCategory.toString();
    } else if(categoryController.text == "Workout") {
      colorCategory = kGreenCategory.toString();
    }
    
    if(priorityController.text == "High") {
      colorPriority = kHighPriority.toString();
    } else if(priorityController.text == "Normal") {
      colorPriority = kNormalPriority.toString();
    } else if(priorityController.text == "Low") {
      colorPriority = kLowPriority.toString();
    }

    FirebaseFirestore.instance.collection("todos").doc(taskName).set({
      "name": taskName,
      "date": dateController.text,
      "start_time": sTimeController.text,
      "end_time": eTimeController.text,
      "category": categoryController.text,
      "color_category": colorCategory,
      "priority": priorityController.text,
      "color_priority": colorPriority,
      "reminder": reminderController.text,
      "notes": notesController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold
          ),
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
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), 
                      lastDate: DateTime(2101)
                    );
                    if(pickedDate != null ){
                      String formattedDate = DateFormat('dd MMMM yyyy').format(pickedDate); 
                      setState(() {
                         dateController.text = formattedDate;
                      });
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
                            TimeOfDay? pickedTime =  await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if(pickedTime != null ){
                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                setState(() {
                                  sTimeController.text = formattedTime; //set the value of text field. 
                                });
                            }
                          },
                        ),
                      )
                    ),
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
                            TimeOfDay? pickedTime =  await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if(pickedTime != null ){
                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                setState(() {
                                  eTimeController.text = formattedTime; //set the value of text field. 
                                });
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
                  items: <String>["Education", "Work", "Workout"]
                    .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                      value: value,
                      child: Text(value == "Education"
                        ? "Education"
                        : value == "Work"
                          ? "Work"
                          : "Workout"),
                    )
                  ).toList(),
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
                      color: categoryController.text == "Education"
                        ? kRedCategory
                        : categoryController.text == "Work"
                          ? kYellowCategory
                          : kGreenCategory,
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
                    )
                  ).toList(),
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
                              : "1 hour before"
                      ),
                    )
                  ).toList(),
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
                      addTask();
                      Navigator.pop(context);
                      print('Task Added');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPurple,
                      textStyle: kHeading6,
                    ),
                    child: const Text('Add Task'),
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