import 'package:flutter/material.dart';

class xColors {
  xColors._();
  //app basic color
  static const Color primary = Color.fromARGB(255, 0, 105, 190);
  static const Color secondary = Color.fromARGB(255, 94, 255, 0);
  static const Color accent = Color.fromARGB(255, 236, 228, 228);
  //gradiant colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9a),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );
//text colors
  static const Color primaryText = Color.fromARGB(255, 43, 41, 41);
  static const Color secoandrtText = Color.fromARGB(255, 69, 72, 97);
  static const Color textwhite = Colors.white;
  //background color
  static const Color Light = Colors.white;
  static const Color Dark = Color.fromARGB(255, 22, 24, 37);
  static const Color primaryColor = Color.fromARGB(255, 182, 197, 245);
  //background Container Color
  static const Color lightContainer = Colors.white;
  static const Color darkContainer = Color.fromARGB(255, 58, 53, 53);
  //error and velidation color
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color wrning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);
  //Neutral shades
  static const Color black = Color(0xFf232323);
  static const Color darkGrey = Color(0xFF4F4f4f);
  static const Color darkgrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softgrey = Color(0xFFF4f4f4);
  static const Color lightgrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color redNotification = Colors.red;
  static const Color fav = Colors.red;
}
