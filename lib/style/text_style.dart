import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// text style
final TextStyle kHeading5 = GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700);
final TextStyle kHeading6 = GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700);
final TextStyle kSubtitle = GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700);
final TextStyle kBodyText = GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);