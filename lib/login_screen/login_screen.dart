import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_with_me/login_screen/signup_screen.dart';
import 'package:do_with_me/style/colors.dart';
import 'package:do_with_me/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widget/button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailAddressController;
  TextEditingController? passwordController;

  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
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
                                hintText: 'Enter your email here...',
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FFButtonWidget(
                          onPressed: () {
                            print('Button-ForgotPassword pressed ...');
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button-Login pressed ...');
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
                            onPressed: () {
                              print('Button-Login pressed ...');
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
    );
  }
}
