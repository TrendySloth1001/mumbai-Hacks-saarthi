import 'package:flutter/material.dart';
import 'custom_theme/app_bar_theme.dart';
import 'custom_theme/bottomsheet_theme.dart';
import 'custom_theme/checkBox_theme.dart';
import 'custom_theme/chip_theme.dart';
import 'custom_theme/elevetedButton_theme.dart';
import 'custom_theme/outlinedButton_theme.dart';
import 'custom_theme/textField_theme.dart';
import 'custom_theme/text_theme.dart';

class xAppTheme {
    xAppTheme._();
    static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: xTextTheme.lightTextTheme,
      elevatedButtonTheme: xElevatedButtonTheme.lightElevatedButtonTheme,
      appBarTheme: xAppBarTheme.lightAppBarTheme,
      checkboxTheme: xCheckBoxTheme.lightCheckBoxTheme, 
      outlinedButtonTheme: xOutlinedButtomTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: xTextFieldTheme.lighttextFieldTheme,
      bottomSheetTheme: xBottomSheetThemeData.lightBottomSheetData,
      chipTheme: xChipTheme.lightChipTheme,
    );
    static  ThemeData DarkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor:  Colors.blue,
      //scaffoldBackgroundColor: Colors.grey.withOpacity(1.0),
      textTheme: xTextTheme.DarkTextTheme,
      elevatedButtonTheme: xElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: xAppBarTheme.darkAppBarTheme,
      checkboxTheme: xCheckBoxTheme.darkCheckBoxTheme, 
      outlinedButtonTheme: xOutlinedButtomTheme.DarkOutlinedButtonTheme,
      inputDecorationTheme: xTextFieldTheme.darktextFieldTheme,
      bottomSheetTheme: xBottomSheetThemeData.darkBottomSheetData,
      chipTheme: xChipTheme.DarkChipTheme,
    );
}