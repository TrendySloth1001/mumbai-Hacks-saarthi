import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigationBar.dart';
import '../resultPages/googleMap.dart';
import '../serchfeature/search.dart';
import '../util/constants/imageStrings_constant.dart';





class OpenLocationPage extends StatelessWidget {
  const OpenLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            StartScreen(),
          ],
        ),
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      xImageStrings.beachimg), // Make sure the path is correct
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Text content
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height *
                0.5, // Adjust based on your preference
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Your Location',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Allow Location Services to find your location or open weather map',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          // Bottom gradient container
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 254,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xCC22445E), Color(0x7700FEB5)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          // Buttons
// First Button: Search for location
          Positioned(
            left: 22,
            bottom: 70,
            child: GestureDetector(
              onTap: () => Get.to(BottomNavBar()),
              child: Container(
                width: MediaQuery.of(context).size.width - 44,
                height: 53,
                decoration: ShapeDecoration(
                  color: Color(0xFF00FEB5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Search for location',
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

// Second Button: Open weather map
          Positioned(
            left: 22,
            bottom: 140,
            child: GestureDetector(
              onTap: () => Get.to(FeatureRichMap()),
              child: Container(
                width: MediaQuery.of(context).size.width - 44,
                height: 53,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Open weather map',
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
    );
  }
}
