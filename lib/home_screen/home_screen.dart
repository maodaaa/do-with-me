import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_with_me/style/colors.dart';
import 'package:do_with_me/style/text_style.dart';
import 'package:flutter/material.dart';

import '../todo/todo_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen2';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                                'Welcome, Jhon',
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
                      mainAxisSize: MainAxisSize.max,
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
                        TaskCard(
                          taskName: "ngerjain pr sekolaaah",
                          startTime: "10.10",
                          endTime: "11.11",
                        ),
                        TaskCard(
                          taskName: "belanja kepasar",
                          startTime: "11.30",
                          endTime: "12.30",
                        ),
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                                  child: Container(
                                    width: 160,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: kRedCategory,
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
                                          Text('School', style: kBodyText.copyWith(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                                  child: Container(
                                    width: 160,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: kYellowCategory,
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
                                              Icons.work,
                                              color: Colors.white,
                                              size: 44,
                                            ),
                                          ),
                                          Text('Work', style: kBodyText.copyWith(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                                  child: Container(
                                    width: 160,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: kGreenCategory,
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
                                              Icons.sports,
                                              color: Colors.white,
                                              size: 44,
                                            ),
                                          ),
                                          Text('Sport', style: kBodyText.copyWith(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                                  child: Container(
                                    width: 160,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: kBrownCategory,
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
                                              Icons.mediation,
                                              color: Colors.white,
                                              size: 44,
                                            ),
                                          ),
                                          Text('Meditation', style: kBodyText.copyWith(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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

class TaskCard extends StatelessWidget {
  String taskName;
  String startTime;
  String endTime;
  TaskCard({
    Key? key,
    required this.taskName,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width - 30,
      height: 70,
      decoration: const BoxDecoration(
        color: kSoftGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              taskName,
              style: kSubtitle.copyWith(color: kBlack),
            ),
            const SizedBox(
              height: 6,
            ),
            Expanded(
              child: Text(
                "$startTime - $endTime",
                style: kBodyText.copyWith(color: kBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
