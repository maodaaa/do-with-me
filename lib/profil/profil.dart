import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/login_screen/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String imagePath = '';
  String name = '';
  int totalTask = 0;
  int finishedTask = 0;
  int ongoingTask = 0;
  bool status = true;

  final String uid = FirebaseAuth.instance.currentUser!.uid;

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

  Future<bool> isCollectionExist(String collectionName) async {
    var value = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(collectionName)
        .limit(1)
        .get();
    return value.docs.isNotEmpty;
  }

  void getTodo() {
    isCollectionExist('todo').then(
      (value) => StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('todo')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            setState(() {
              totalTask = snapshot.data!.docs.length;
              finishedTask = snapshot.data!.docs
                  .where((e) => e['finished'] == true)
                  .length;
              ongoingTask = snapshot.data!.docs
                  .where((e) => e['finished'] == false)
                  .length;
            });
          }

          return const SizedBox();
        },
      ),
    );
  }

  Future getUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((userData) => setState(() {
              imagePath = userData.data()!['image_path'];
            }));
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Stack(
                children: [
                  Center(
                    child: imagePath.isNotEmpty
                        ? Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: kBlack),
                              image: DecorationImage(
                                image: NetworkImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 210, 210, 210),
                              shape: BoxShape.circle,
                              border: Border.all(color: kBlack),
                            ),
                            child: Center(
                              child: Text('No Image', style: kBodyText),
                            ),
                          ),
                  ),
                  Positioned(
                    top: 150,
                    right: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kPurple,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: IconButton(
                        color: kWhite,
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          PickedFile? file = await getImage();
                          imagePath = await uploadImage(File(file!.path));

                          if (imagePath.isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .update({'image_path': imagePath});
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                auth.currentUser!.displayName ?? 'John Doe',
                style: kHeading5,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        totalTask.toString(),
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
                        finishedTask.toString(),
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
                        ongoingTask.toString(),
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Delete Account', style: kHeading6),
                        content: Text('Are you sure to delete your account?',
                            style: kBodyText),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPurple,
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPurple,
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .delete()
                                  .then((_) {
                                User? user = FirebaseAuth.instance.currentUser;
                                user!.delete().then((_) => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInScreen()),
                                        (route) => false));
                              });
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
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
