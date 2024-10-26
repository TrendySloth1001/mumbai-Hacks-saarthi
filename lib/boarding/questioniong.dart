import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'weather_parameters.dart';

class RdPreferenceScreen extends StatefulWidget {
  @override
  _RdPreferenceScreenState createState() => _RdPreferenceScreenState();
}

class _RdPreferenceScreenState extends State<RdPreferenceScreen> {
  int? _selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22445E),
      body: Stack(
        children: [
          Center(
            heightFactor: 1.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHeader(),
                  SizedBox(height: 20),
                  _buildOptionsList(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                print('Skip button pressed');
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: _buildContinueButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'How did you find Saarthi?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildOptionsList() {
    final List<String> options = [
      'My friend uses Saarthi',
      'My coach/instructor recommended it',
      'It was mentioned on social media',
      'I just found the app by myself',
    ];

    return Column(
      children: options.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        return _buildOptionTile(option, index);
      }).toList(),
    );
  }

  Widget _buildOptionTile(String optionText, int index) {
    bool isSelected = _selectedOptionIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedOptionIndex = index;
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF305B7C) : Color(0xFF305B7C),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Color(0xFF00FEB5) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Text(
            optionText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: 346,
      height: 53,
      decoration: ShapeDecoration(
        color: _selectedOptionIndex != null ? Color(0xFF00FEB5) : Color(0xFF366386),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: ElevatedButton(
        onPressed: _selectedOptionIndex == null
            ? null
            : () => Get.to(GeolocationAccessApp()),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          side: BorderSide.none,
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            color: Color(0xFF22445E),
            fontSize: 18,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
