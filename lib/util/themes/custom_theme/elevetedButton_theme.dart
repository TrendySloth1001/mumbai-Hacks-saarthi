import 'package:flutter/material.dart';

 class xElevatedButtonTheme {
  xElevatedButtonTheme._();
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      textStyle: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.grey,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: Colors.white,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      textStyle: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}