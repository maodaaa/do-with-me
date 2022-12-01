import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/home_screen/home_screen.dart';
import 'package:do_with_me/login_screen/signin_screen.dart';
import 'package:do_with_me/service/firebase_auth_service.dart';
import 'package:do_with_me/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController? nameController;
  TextEditingController? emailAddressController;
  TextEditingController? passwordController;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailAddressController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  Future<void> _signUpInWitEmail(String name, String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuthService().signUpInWitEmail(
      name,
      email,
      password,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sign Up', style: kHeading5.copyWith(color: kBlack)),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                controller: nameController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: kSubtitle.copyWith(color: kBlack),
                                  hintText: 'Enter your name here...',
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
                                style: kBodyText,
                                maxLines: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: TextFormField(
                                controller: emailAddressController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: kSubtitle.copyWith(color: kBlack),
                                  hintText: 'Enter your email here...',
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
                                style: kBodyText,
                                maxLines: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: kSubtitle.copyWith(color: kBlack),
                                hintText: 'Enter your password here...',
                                hintStyle: kBodyText,
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
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility = !passwordVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                    color: const Color(0xFF57636C),
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: kBodyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              try {
                                await _signUpInWitEmail(
                                  nameController!.text,
                                  emailAddressController!.text,
                                  passwordController!.text,
                                );
                              } on FirebaseAuthException catch (e) {
                                showSnackbar(
                                  context,
                                  e.message.toString(),
                                );
                              }
                              var users = FirebaseAuth.instance;
                              var firestore = FirebaseFirestore.instance;
                              if (users.currentUser != null) {
                                print(users.currentUser!.uid);
                                final uid = users.currentUser!.uid;
                                final todoCollectionRef = firestore.collection("users").doc(uid);
                                await todoCollectionRef.set({
                                  "name": users.currentUser!.displayName,
                                  "email": users.currentUser!.email,
                                  "userCreated": FieldValue.serverTimestamp(),
                                  "lastSignIn": FieldValue.serverTimestamp(),
                                });

                                Navigator.pushNamed(context, HomeScreen.routeName);
                              }
                            },
                            text: 'Create a new account ',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50,
                              color: kPurple,
                              textStyle: kSubtitle,
                              elevation: 3,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'or',
                            textAlign: TextAlign.center,
                            style: kBodyText.copyWith(color: kBlack),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button-Login pressed ...');
                            },
                            text: 'Sign Up with Google',
                            icon: Image.asset(
                              'assets/logogoogle.png',
                              fit: BoxFit.fill,
                            ),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50,
                              color: kSoftGrey,
                              textStyle: kSubtitle.copyWith(color: kBlack),
                              elevation: 2,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an Account?',
                            style: kBodyText.copyWith(color: kBlack),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              Navigator.pushNamed(context, SignInScreen.routeName);
                            },
                            text: 'Log in',
                            options: FFButtonOptions(
                              padding: EdgeInsets.zero,
                              width: 100,
                              height: 30,
                              color: const Color(0x00FFFFFF),
                              textStyle: kBodyText.copyWith(color: kPurple, fontWeight: FontWeight.w700),
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPurple,
      content: Text(
        message.toString(),
      ),
    ),
  );
}
