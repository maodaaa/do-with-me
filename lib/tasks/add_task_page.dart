import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/todo/todo_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
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
  TextEditingController notesController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController sTimeController = TextEditingController();
  TextEditingController eTimeController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  late final SingleValueDropDownController _cnt = SingleValueDropDownController();
  late final SingleValueDropDownController _cnt2 = SingleValueDropDownController();
  late final SingleValueDropDownController _cnt3 = SingleValueDropDownController();

  @override
  void initState() {
    taskController.text = "";
    notesController.text = "";
    dateController.text = "";
    sTimeController.text = "";
    eTimeController.text = "";
    _cnt.dropDownValue?.name;
    _cnt2.dropDownValue?.name;
    _cnt3.dropDownValue?.name;
    super.initState();
  }

  @override
  void dispose() {
    taskController.dispose();
    notesController.dispose();
    dateController.dispose();
    sTimeController.dispose();
    eTimeController.dispose();
    _cnt.dispose();
    _cnt2.dispose();
    _cnt3.dispose();
    super.dispose();
  }

  void addTask() {
    final taskName = taskController.text;
    var colorCategory = "";
    var colorPriority = "";
    
    if(_cnt.dropDownValue?.name == "Education") {
      colorCategory = kRedCategory.toString();
    } else if(_cnt.dropDownValue?.name == "Work") {
      colorCategory = kYellowCategory.toString();
    } else if(_cnt.dropDownValue?.name == "Workout") {
      colorCategory = kGreenCategory.toString();
    }
    
    if(_cnt2.dropDownValue?.name == "High") {
      colorPriority = kHighPriority.toString();
    } else if(_cnt2.dropDownValue?.name == "Normal") {
      colorPriority = kNormalPriority.toString();
    } else if(_cnt2.dropDownValue?.name == "Low") {
      colorPriority = kLowPriority.toString();
    }

    FirebaseFirestore.instance.collection("todos").doc(taskName).set({
      "name": taskName,
      "date": dateController.text,
      "start_time": sTimeController.text,
      "end_time": eTimeController.text,
      "category": _cnt.dropDownValue?.name,
      "color_category": colorCategory,
      "priority": _cnt2.dropDownValue?.name,
      "color_priority": colorPriority,
      "reminder": _cnt3.dropDownValue?.name,
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
                child: DropDownTextField(
                  padding: const EdgeInsets.all(16),
                  controller: _cnt,
                  clearOption: true,
                  textStyle: kBodyText,
                  textFieldDecoration: InputDecoration(
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
                    prefixIcon: const Icon(Icons.circle, color: Colors.grey),
                  ),
                  clearIconProperty: IconProperty(color: kPurple),
                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  dropDownList: const [
                    DropDownValueModel(name: 'Education', value: "Education"),
                    DropDownValueModel(name: 'Work', value: "Work"),
                    DropDownValueModel(name: 'Workout', value: "Workout"),
                  ],
                  listTextStyle: kBodyText,
                  onChanged: (val) {
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropDownTextField(
                  padding: const EdgeInsets.all(16),
                  controller: _cnt2,
                  clearOption: true,
                  textStyle: kBodyText,
                  textFieldDecoration: InputDecoration(
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
                    prefixIcon: const Icon(Icons.circle, color: Colors.grey),
                  ),
                  clearIconProperty: IconProperty(color: kPurple),
                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  dropDownList: const [
                    DropDownValueModel(name: 'High', value: "High"),
                    DropDownValueModel(name: 'Normal', value: "Normal"),
                    DropDownValueModel(name: 'Low', value: "Low"),
                  ],
                  listTextStyle: kBodyText,
                  onChanged: (val) {
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropDownTextField(
                  padding: const EdgeInsets.all(16),
                  controller: _cnt3,
                  clearOption: true,
                  textStyle: kBodyText,
                  textFieldDecoration: InputDecoration(
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
                  clearIconProperty: IconProperty(color: kPurple),
                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  dropDownList: const [
                    DropDownValueModel(name: '5 minutes before', value: "5"),
                    DropDownValueModel(name: '10 minutes before', value: "10"),
                    DropDownValueModel(name: '15 minutes before', value: "15"),
                    DropDownValueModel(name: '30 minutes before', value: "30"),
                    DropDownValueModel(name: '1 hour before', value: "60"),
                  ],
                  listTextStyle: kBodyText,
                  onChanged: (val) {
                  },
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
                    child: Text('Add Task'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPurple,
                      textStyle: kHeading6,
                    ),
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