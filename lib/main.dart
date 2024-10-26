import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'boarding/onboarding_page.dart';
import 'util/themes/theme.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return GetMaterialApp( 
      themeMode: ThemeMode.system,
      theme:xAppTheme.lightTheme,
      darkTheme:  xAppTheme.DarkTheme,
      home:  OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
