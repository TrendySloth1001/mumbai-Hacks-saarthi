import 'package:flutter/material.dart';


import 'search.dart';
import 'searchScreen.dart';

class SearchScreenUsr extends StatelessWidget {
  const SearchScreenUsr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A5F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SearchPageUi(),
                const SizedBox(height: 10),
                Container(
                  width: 390.02,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF00FEB5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const WeatherMap(),
                const FavoriteSpots(),
                const CommunitySection(),
                const NearestSpots(),
                const SeeMoreButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
