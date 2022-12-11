import 'package:do_with_me/core/styles/colors.dart';
import 'package:do_with_me/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPurple,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'Do With Me',
              style: kHeading5.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
