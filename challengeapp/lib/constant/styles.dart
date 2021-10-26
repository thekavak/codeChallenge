import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ThemeText {
  static const backgroundColor = Color(0xFFF0F1F6);
  static const bottomBoxColor = Color(0xFF3B3054);
  static const buttonColor = Color(0xFF2CCFCF);
  static const blackColor = Colors.black;
  static const whiteColor = Colors.white;
  static const greyColor = Colors.grey;
  static const redColor = Colors.red;

  static TextStyle letsGetTextOpenSans = GoogleFonts.openSans(
    color: blackColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.8,
  );
  static TextStyle letsGetTextDescOpenSans = GoogleFonts.openSans(
    color: blackColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle hintTextOpenSans = GoogleFonts.openSans(
    fontSize: 18.0,
    color:greyColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle hintMissingTextOpenSans = GoogleFonts.openSans(
    fontSize: 18.0,
    color: redColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle buttomTextOpenSans = GoogleFonts.openSans(
    fontSize: 20.0,
    color: whiteColor,
    fontWeight: FontWeight.bold,
  );
}
