import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:do_with_me/login_screen/signin_screen.dart';
import 'package:do_with_me/widget/button.dart';
import 'package:do_with_me/widget/showsnackbar.dart';
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
  final users = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Sign Up',
                    style: kHeading5.copyWith(color: kBlack),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(17),
                  child: TextFormField(
                    controller: nameController,
                    obscureText: false,
                    style: kBodyText,
                    decoration: InputDecoration(
                      labelText: 'Name',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot empty';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 0, 17, 17),
                  child: TextFormField(
                    controller: emailAddressController,
                    obscureText: false,
                    style: kBodyText,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email cannot empty';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 0, 17, 17),
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
                            contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
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
                              return 'email cannot empty';
                            } else if (value.length < 6) {
                              return 'Password must 6 character';
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
                  padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          signUpWithEmail();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPurple,
                        textStyle: kSubtitle,
                      ),
                      child: const Text('Create an account'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'or',
                        textAlign: TextAlign.center,
                        style: kBodyText.copyWith(color: kBlack),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 0, 17, 17),
                  child: Row(
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
                          Navigator.pop(context);
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
        ),
      ),
    );
  }

  Future signUpWithEmail() async {
    try {
      var newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailAddressController!.text, password: passwordController!.text);
      if (newUser.additionalUserInfo!.isNewUser) {
        await FirebaseFirestore.instance.collection("users").doc(newUser.user?.uid).set({
          "uid": newUser.user!.uid,
          "name": nameController!.text,
          "image_path": "",
          "email": emailAddressController!.text,
          "userCreated": FieldValue.serverTimestamp(),
          "lastSignIn": FieldValue.serverTimestamp(),
        });
        newUser.user!.sendEmailVerification();
        if (!mounted) return;
        showSnackbar(context, "email verification has send to ${newUser.user!.email}");
        Navigator.popAndPushNamed(context, SignInScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }
}
