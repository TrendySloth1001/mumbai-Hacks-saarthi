import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../util/constants/imageStrings_constant.dart';



class WeatherMap extends StatelessWidget {
  const WeatherMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Map',
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            height: 202,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    xImageStrings.mapgif,
                    width: double.infinity,
                    height: 202,
                    fit: BoxFit.cover,
                    semanticLabel: 'Weather map image',
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Image.asset(
                      xImageStrings.mapgif,
                      height: 20,
                      semanticLabel: 'Google logo',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteSpots extends StatelessWidget {
  const FavoriteSpots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Favorite Spots',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 25),
            decoration: BoxDecoration(
              color: Color(0xFF1E3A5F),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFF2D5275), width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                    children: [
                      TextSpan(text: 'Press '),
                      WidgetSpan(
                        child: Icon(Icons.star, color: Color(0xFF00FEB5), size: 20),
                        alignment: PlaceholderAlignment.middle,
                      ),
                      TextSpan(text: ' on the screen to add your\nfavorite Spot to your List.'),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add favorite spot logic here
                  },
                  icon: Icon(Icons.star, color: Color(0xFF22445E), size: 20),
                  label: Text(
                    'Add to Favorites',
                    style: TextStyle(color: Color(0xFF22445E), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00FEB5),
                    foregroundColor: Color(0xFF22445E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommunitySection extends StatelessWidget {
  const CommunitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF2E5A7C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 3,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(xImageStrings.G20Logo),
                    radius: 15,
                  ),
                ),
                Positioned(
                  right: -3,
                  top: 3,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(xImageStrings.openMeto),
                    radius: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Community',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }
}

class NearestSpots extends StatelessWidget {
  const NearestSpots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearest Spots',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'See All',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 16),
          NearestSpotItem(
            name: 'Edmonds Marina Park',
            distance: '7708 mi',
            rating: '205',
            icon: xImageStrings.sealingImg,
          ),
          SizedBox(height: 18),
          NearestSpotItem(
            name: 'Miami beach Marina',
            distance: '3907 mi',
            rating: '510',
            icon: xImageStrings.sealingImg,
          ),
          SizedBox(height: 18),
          NearestSpotItem(
            name: 'HerbBeck Marina Beach',
            distance: '7703 mi',
            rating: '9',
            icon: xImageStrings.sealingImg,
          ),
        ],
      ),
    );
  }
}

class NearestSpotItem extends StatelessWidget {
  final String name;
  final String distance;
  final String rating;
  final String icon;

  const NearestSpotItem({
    Key? key,
    required this.name,
    required this.distance,
    required this.rating,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFF2E5A7C),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.location_on, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 14),
                    SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                    ),
                    SizedBox(width: 25),
                    Text(
                      distance,
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: Color(0xFF2E5A7C),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: 48.06,
                height: 40.89,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 67,
      decoration: BoxDecoration(
        color: Color(0xFF305B7C),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'See More',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 18),
            Icon(Iconsax.arrow_down_1, color: Colors.white),
          ],
        ),
      ),
    );
  }
}