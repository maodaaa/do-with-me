import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/todo/todo_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime focusDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = focusDay;
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration: const BoxDecoration(
                    color: kPurple,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(17, 50, 17, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "${auth.currentUser!.displayName}",
                                style: kHeading5.copyWith(color: kWhite),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Don’t forget your tasks!',
                                style: kBodyText.copyWith(color: kWhite),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 190, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(17, 16, 17, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Today's Task",
                                  textAlign: TextAlign.start,
                                  style: kSubtitle.copyWith(color: kBlack),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: kBodyText,
                                  foregroundColor: Colors.purple,
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(4),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, ToDoPage.routeName);
                                },
                                child: Text(
                                  'See all',
                                  style: kBodyText.copyWith(color: kBlack),
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .collection("todo")
                                .where('date', isEqualTo: DateFormat('dd MMMM yyyy').format(_selectedDay!))
                                .orderBy('start_time', descending: false)
                                .limit(2)
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
                              if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No Tasks',
                                    style: kHeading6Normal,
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    return TaskCard(
                                      uid: auth.currentUser!.uid,
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
                                    );
                                  }),
                                );
                              }

                              return Container();
                            }),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(17, 16, 17, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Categories",
                                  textAlign: TextAlign.start,
                                  style: kSubtitle.copyWith(color: kBlack),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: const BoxDecoration(
                            color: kWhite,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const CategoryCard(name: "School", colorCategory: kRedCategory),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CategoryCard(name: "Work", colorCategory: kYellowCategory),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CategoryCard(name: "Sport", colorCategory: kGreenCategory),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CategoryCard(name: "Meditation", colorCategory: kBrownCategory),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final Color colorCategory;

  const CategoryCard({super.key, required this.name, required this.colorCategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
      child: Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: colorCategory,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                child: Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              Text(name, style: kBodyText.copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String uid;
  final String id;
  final String name;
  final String date;
  final String sTime;
  final String eTime;
  final String category;
  final String colorCategory;
  final String priority;
  final String colorPriority;
  final String reminder;
  final String notes;

  const TaskCard({
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
  });

  @override
  Widget build(BuildContext context) {
    String valueString = colorCategory.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: const BoxDecoration(
        color: kSoftGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: kSubtitle.copyWith(color: kBlack),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('$sTime - $eTime', style: kBodyText),
            ],
          ),
        ),
        trailing: Padding(padding: const EdgeInsets.only(right: 10), child: Icon(Icons.circle, color: otherColor)),
      ),
    );
  }
}
