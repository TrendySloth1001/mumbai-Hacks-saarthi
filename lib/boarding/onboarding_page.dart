import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/constants/imageStrings_constant.dart';
import 'preferances.dart'; // Replace with actual image paths

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with blur
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    xImageStrings.beach), // Replace with actual image
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          // Foreground Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Color(0xFF22445E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'In Collaboration with',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Ministry of Earth Sciences, Govt. of India',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Logos Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // First Logo (INCOIS)
                      Container(
                        width: 115,
                        height: 115,
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [
                              Color(0xFF0154A0),
                              Color(0xFF0F56A4),
                              Color(0xFF5987CA)
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(59),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 95,
                              height: 95,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(xImageStrings.openMeto),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      // Divider
                      Container(
                        height: screenHeight * 0.15,
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      // Second Logo (G20)
                      Container(
                        width: 115,
                        height: 115,
                        padding: const EdgeInsets.only(
                            top: 15, left: 3, right: 4, bottom: 15),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(59),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 108,
                              height: 85,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(xImageStrings.LLAMA),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.offAll(() => WeatherCheckApp()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF00FEB5), // Custom button color
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        textStyle: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Color(0xFF22445E),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Terms and Conditions
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Text(
                      'By proceeding, you confirm that you have read the Privacy Policy, '
                      'User Agreement and accepted their terms and conditions.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.035,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Open link to terms and conditions
                    },
                    child: Text(
                      'Click to read.',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: screenWidth * 0.03,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
