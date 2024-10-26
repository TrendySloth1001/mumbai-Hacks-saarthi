import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'selectOptionspage.dart';

class WeatherCheckApp extends StatefulWidget {
  @override
  _WeatherCheckAppState createState() => _WeatherCheckAppState();
}

class _WeatherCheckAppState extends State<WeatherCheckApp> {
  // Keep track of the selected card (single selection)
  String? _selectedCard;

  void _selectCard(String cardType) {
    setState(() {
      _selectedCard = cardType;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCardSelected = _selectedCard != null;

    return Scaffold(
      backgroundColor: Color(0xFF22445E), // Dark background for better contrast
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "How deep do you go when you check the weather?",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 20),
                    WeatherCheckCard(
                      type: 'General',
                      description: 'I quickly check\nessential parameters',
                      color: Color(0xFF00FE69),
                      isSelected: _selectedCard == 'General',
                      onTap: () => _selectCard('General'),
                    ),
                    SizedBox(height: 10),
                    WeatherCheckCard(
                      type: 'Intermediate',
                      description: 'I review forecasts from \nseveral models',
                      color: Color(0xFFFEF100),
                      isSelected: _selectedCard == 'Intermediate',
                      onTap: () => _selectCard('Intermediate'),
                    ),
                    SizedBox(height: 10),
                    WeatherCheckCard(
                      type: 'Advanced',
                      description:
                          'Compare multiple weather sources & hyperlocal models',
                      color: Color(0xFFFE5E5E),
                      isSelected: _selectedCard == 'Advanced',
                      onTap: () => _selectCard('Advanced'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 346, // Custom width
              height: 53, // Custom height
              decoration: ShapeDecoration(
                color: isCardSelected
                    ? Color(0xFF00FEB5)
                    :  Color(0xFF366386), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(7), // Custom border radius
                ),
              ),
              child: ElevatedButton(
                onPressed: isCardSelected
                    ? () => Get.to(SelectSportScreen())
                    : null, // Conditional action
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Transparent to use the container's color
                  shadowColor: Colors.transparent, // Remove button shadow
                  padding: EdgeInsets
                      .zero, // Remove default padding to match custom decoration
                  side: BorderSide
                      .none, // Remove the border (including the blue outline)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF123754), // Custom text color
                        fontSize: 18,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.0, // Adjust for line height if needed
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16), // Space between button and bottom
          ],
        ),
      ),
    );
  }
}

class WeatherCheckCard extends StatelessWidget {
  final String type;
  final String description;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const WeatherCheckCard({
    required this.type,
    required this.description,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blueGrey.shade800, // Slightly lighter blue card color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded card corners
        ),
        elevation: 4, // Shadow effect for depth
        margin: EdgeInsets.symmetric(vertical: 8), // Card margin
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFF305B7C),
            borderRadius: BorderRadius.circular(12), // Match card corner radius
            border: Border.all(
              color: isSelected
                  ? Color(0xFF00FEB5)
                  : Colors.transparent, // Border color when selected
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
