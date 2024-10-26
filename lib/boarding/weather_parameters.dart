import 'dart:ui'; // For ImageFilter.blur
import 'package:flutter/material.dart';

import '../util/constants/imageStrings_constant.dart';
import 'openLocationPAge.dart';

// Main Application
void main() {
  runApp(GeolocationAccessApp());
}

class GeolocationAccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: GeolocationAccess(),
    );
  }
}

class GeolocationAccess extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Fullscreen background image with opacity
        Positioned.fill(
          child: Opacity(
            opacity: 1.0, // Set the desired opacity here (0.0 to 1.0)
            child: Image.asset(
              xImageStrings.earthImg, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Content over the image
        ListView(
          children: [
            GeolocationEnable(),
          ],
        ),
      ],
    ),
  );
}
}

class GeolocationEnable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 844,
          child: Stack(
            children: [
              Positioned(
                left: 86,
                top: 81,
                child: Text(
                  'Allow Geolocation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 119,
                child: Text(
                  'To see nearby locations-',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 119,
                top: 141,
                child: Text(
                  'enable geolocation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Allow Geolocation Button
              Positioned(
                left: 146,
                top: 754,
                child: GestureDetector(
                  onTap: () => _onAllowGeolocationPressed(context),
                  child: Container(
                    width: 217,
                    height: 53,
                    decoration: ShapeDecoration(
                      color: Color(0xFF00FEB5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    ),
                    child: Center(
                      child: Text(
                        'Allow Geolocation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF22445E),
                          fontSize: 18,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Skip Button
              Positioned(
                left: 18,
                top: 754,
                child: GestureDetector(
                  onTap: () {
                    // Custom SnackBar for Skip button
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        content: Stack(
                          children: [
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.clear, color: Colors.white),
                                  SizedBox(width: 16),
                                  Text(
                                    'Geolocation Access Skipped!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                    );
                  },
                  child: Container(
                    width: 112,
                    height: 53,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Skip',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Function to handle Allow Geolocation button press
  void _onAllowGeolocationPressed(BuildContext context) {
    // Navigate to OpenLocationPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartScreen()),
    );

    // Custom SnackBar with blur effect
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 80, // Bigger snackbar
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 16),
                  Text(
                    'Geolocation Access Granted!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18, // Bigger text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
    );
  }
}

