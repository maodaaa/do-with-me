import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/home_screen/home_screen.dart';
import 'package:do_with_me/login_screen/reset_password_screen.dart';
import 'package:do_with_me/login_screen/signup_screen.dart';
import 'package:do_with_me/service/firebase_auth_service.dart';
import 'package:do_with_me/widget/showsnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/button.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final users = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  TextEditingController? emailAddressController;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Allow Notifications'),
                  content: const Text('Our app would like to send you notifications'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Don\'t Allow',
                        style: TextStyle(
                          color: kGrey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context)),
                      child: const Text(
                        'Allow',
                        style: TextStyle(
                          color: kPurple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ));
      }
    });
  }

  @override
  void dispose() {
    emailAddressController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  Future<void> _loginGoogle() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuthService().signInWithGoogle();
    if (users.currentUser!.uid.isNotEmpty) {
      if (!mounted) return;
      Navigator.popAndPushNamed(context, HomeScreen.routeName);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                      Text('Sign in', style: kHeading5.copyWith(color: kBlack)),
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
                                        color: Colors.redAccent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: kPurple,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email cannot empty';
                                    }
                                    return null;
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                      color: Colors.redAccent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: kPurple,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password cannot empty';
                                  }
                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FFButtonWidget(
                              onPressed: () {
                                Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                              },
                              text: 'Forgot Password?',
                              options: FFButtonOptions(
                                height: 40,
                                color: const Color(0x00FFFFFF),
                                textStyle: kBodyText.copyWith(color: kBlack),
                                elevation: 0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
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
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  signInWithEmail();
                                }
                              },
                              text: 'Login',
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
                              onPressed: () async {
                                try {
                                  await _loginGoogle();
                                } on FirebaseAuthException catch (e) {
                                  showSnackbar(
                                    context,
                                    e.message.toString(),
                                  );
                                }
                              },
                              text: 'Login with Google',
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
                              'Don\'t have an account?',
                              style: kBodyText.copyWith(color: kBlack),
                            ),
                            FFButtonWidget(
                              onPressed: () {
                                Navigator.pushNamed(context, SignupScreen.routeName);
                              },
                              text: 'Sign Up',
                              options: FFButtonOptions(
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
      ),
    );
  }

  Future signInWithEmail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddressController!.text,
        password: passwordController!.text,
      );
      if (users.currentUser != null) {
        if (users.currentUser!.emailVerified) {
          final userCollectionRef = firestore.collection("users");
          for (final providerProfile in users.currentUser!.providerData) {
            final uid = users.currentUser!.uid;
            final name = providerProfile.displayName;
            final emailAddress = providerProfile.email;
            final snapShot = await userCollectionRef.doc(uid).get();
            if (snapShot.exists) {
              await userCollectionRef.doc(uid).update({
                "lastSignIn": FieldValue.serverTimestamp(),
              });
            } else {
              await userCollectionRef.doc(uid).set({
                "name": name,
                "email": emailAddress,
                "userCreated": FieldValue.serverTimestamp(),
                "lastSignIn": FieldValue.serverTimestamp(),
              });
            }
          }
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          emailAddressController!.clear();
          passwordController!.clear();
        } else {
          if (!mounted) return;
          showSnackbar(context, "your account is not verified, Check email for verified account");
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context,
        e.message.toString(),
      );
    }
  }
}
