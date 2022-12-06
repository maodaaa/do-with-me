import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/login_screen/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  static const routeName = '/profil-page';
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool status = true;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
              const SizedBox(height: 25),
              const Divider(height: 1, color: Color.fromRGBO(0, 0, 0, 0.300)),
              Container(
                width: MediaQuery.of(context).size.width,
                color: kGrey,
                child: ListTile(
                  title: const Text('Push Notification'),
                  trailing: Switch(
                    activeColor: kPurple,
                    value: status,
                    onChanged: (bool state) => setState(() => status = state),
                  ),
                ),
              ),
              const Divider(height: 1, color: Color.fromRGBO(0, 0, 0, 0.300)),
              Container(
                width: MediaQuery.of(context).size.width,
                color: kGrey,
                child: const ListTile(
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              const Divider(height: 1, color: Color.fromRGBO(0, 0, 0, 0.300)),
              Container(
                width: MediaQuery.of(context).size.width,
                color: kGrey,
                child: ListTile(
                  title: const Text('Delete Account'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
              const Divider(height: 1, color: Color.fromRGBO(0, 0, 0, 0.300)),
              const SizedBox(height: 150),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPurple,
                  textStyle: kHeading6,
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then(
                        (_) => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                            (route) => false),
                      );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Text('Logout'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
