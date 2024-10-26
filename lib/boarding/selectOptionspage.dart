import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'questioniong.dart';

class SelectSportScreen extends StatefulWidget {
  @override
  _SelectSportScreenState createState() => _SelectSportScreenState();
}

class _SelectSportScreenState extends State<SelectSportScreen> {
  final List<Map<String, dynamic>> sports = [
    {'icon': Icons.sailing, 'label': 'Sailing', 'selected': false},
    {'icon': Icons.pool, 'label': 'Swimming', 'selected': false},
    {'icon': Icons.set_meal, 'label': 'Fishing', 'selected': false},
    {'icon': Icons.surfing, 'label': 'Windsurfing', 'selected': false},
    {'icon': Icons.waves, 'label': 'Surfing', 'selected': false},
    {'icon': Icons.kitesurfing, 'label': 'Kitesurfing', 'selected': false},
    {'icon': Icons.rowing, 'label': 'SUP', 'selected': false},
    {'icon': Icons.kayaking, 'label': 'Kayaking', 'selected': false},
    {'icon': Icons.scuba_diving, 'label': 'Scuba Diving', 'selected': false},
    {'icon': Icons.directions_bike, 'label': 'Cycling', 'selected': false},
    {'icon': Icons.paragliding, 'label': 'Paragliding', 'selected': false},
    {'icon': Icons.sports, 'label': 'Other', 'selected': false},
  ];

  bool get isAnySportSelected => sports.any((sport) => sport['selected']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF254660),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Select Your Sport',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'We will personalize the app according to your choice',
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: sports.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        sports[index]['selected'] = !sports[index]['selected'];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: sports[index]['selected']
                                ? Colors.white.withOpacity(0.3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            sports[index]['icon'],
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          sports[index]['label'],
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: ElevatedButton(
                onPressed: isAnySportSelected
                    ? () => Get.to(RdPreferenceScreen())
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isAnySportSelected ? Color(0xFF00FEB5) : Color(0xFF305B7C),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Select',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}