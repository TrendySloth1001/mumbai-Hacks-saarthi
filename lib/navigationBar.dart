import 'package:flutter/material.dart';

import 'features/chat.dart';
import 'features/shoaping.dart';
import 'resultPages/chatPage.dart';
import 'resultPages/googleMap.dart';
import 'serchfeature/search.dart';



class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  bool _showAddPage = false;

  final List<IconData> _navItems = [
    Icons.home,
    Icons.map_outlined,
    Icons.all_inclusive,
    Icons.shop_2,
  ];

  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    InfinityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _showAddPage ? AddPage() : _pages[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF0D9488), // Teal color
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_navItems.length, (index) {
                    return IconButton(
                      icon: Icon(
                        _navItems[index],
                        color: (!_showAddPage && _selectedIndex == index)
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = index;
                          _showAddPage = false;
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 45,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Container(
          //       width: 56,
          //       height: 56,
          //       decoration: BoxDecoration(
          //         color: Color(0xFFFB923C), // Orange color
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.orange.withOpacity(0.3),
          //             blurRadius: 10,
          //             offset: Offset(0, 5),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchPageUi();
  }
}

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FeatureRichMap(),
    );
  }
}

class InfinityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:FoodShoppingPage());
  }
}

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Add Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// Example usage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(),
      theme: ThemeData(
        primaryColor: Color(0xFF0D9488),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}