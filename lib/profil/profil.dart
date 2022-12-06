import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/login_screen/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfilPage extends StatefulWidget {
  static const routeName = '/profil-page';
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late String imagePath;
  final User? user = FirebaseAuth.instance.currentUser;
  bool status = true;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String> uploadImage(File imageFile) async {
    String fileName = basename(imageFile.path);

    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = ref.putFile(imageFile);
    TaskSnapshot snapshot = await task.whenComplete(() => null);

    return snapshot.ref.getDownloadURL();
  }

  Future<PickedFile?> getImage() async {
    return await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Stack(
                children: [
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
                  Positioned(
                    top: -1,
                    bottom: 1,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        PickedFile? file = await getImage();
                        imagePath = await uploadImage(File(file!.path));
                        setState(() {});
                      },
                    ),
                  )
                ],
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
