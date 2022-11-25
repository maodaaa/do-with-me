import 'package:do_with_me/calendar/calendar.dart';
import 'package:do_with_me/style/colors.dart';
import 'package:do_with_me/style/text_style.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 25),
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: kBlack,
                    child: Text(
                      'No Image',
                      style: kBodyText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "John Doe",
                  style: kHeading5,
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "40",
                          style: kHeading6,
                        ),
                        Text(
                          "Total Task",
                          style: kBodyText,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "20",
                          style: kHeading6,
                        ),
                        Text(
                          "Complete",
                          style: kBodyText,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "20",
                          style: kHeading6,
                        ),
                        Text(
                          "Ongoing",
                          style: kBodyText,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, color: Color.fromRGBO(0, 0, 0, 0.300)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
