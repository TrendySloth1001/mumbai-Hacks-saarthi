import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../resultPages/resultPage.dart';
import '../resultPages/searchResult.dart';

class SearchPageUi extends StatefulWidget {
  const SearchPageUi({Key? key}) : super(key: key);

  @override
  _SearchPageUiState createState() => _SearchPageUiState();
}

class _SearchPageUiState extends State<SearchPageUi> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  String _activeTab = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      _performSearch(_searchController.text);
    } else {
      setState(() {
        _searchResults.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E3A5F),
      body: SafeArea(
        child: Column(
          children: [
            SearchBarUi(
              controller: _searchController,
              onSearch: _performSearch,
              onClear: _clearSearch,
            ),
            TabBar(
              activeTab: _activeTab,
              onTabChanged: (tab) => setState(() => _activeTab = tab),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      'Search result',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 5,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length + 1,
      itemBuilder: (context, index) {
        if (index == _searchResults.length) {
          return Center(
              child: Column(
            children: [
              Text(
                "Near By Locations",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Column(
                children: [
                  NearestSpotItem(
                    name: 'Juhu Beach',
                    distance: '12 km', // Example distance
                    rating: '4.5', // Example rating
                    icon:
                        'assets/icons/juhu_beach.png', // Replace with your icon path
                    lat: "19.0937",
                    lon: "72.8258",
                  ),
                  NearestSpotItem(
                    name: 'Aksa Beach',
                    distance: '15 km', // Example distance
                    rating: '4.3', // Example rating
                    icon:
                        'assets/icons/aksa_beach.png', // Replace with your icon path
                    lat: "19.1974",
                    lon: "72.8221",
                  ),
                  NearestSpotItem(
                    name: 'Chopati Beach',
                    distance: '10 km', // Example distance
                    rating: '4.7', // Example rating
                    icon:
                        'assets/icons/chopati_beach.png', // Replace with your icon path
                    lat: "18.9656",
                    lon: "72.8234",
                  ),
                  NearestSpotItem(
                    name: 'Versova Beach',
                    distance: '11 km', // Example distance
                    rating: '4.6', // Example rating
                    icon:
                        'assets/icons/versova_beach.png', // Replace with your icon path
                    lat: "19.1346",
                    lon: "72.8355",
                  ),
                  NearestSpotItem(
                    name: 'Madh Island',
                    distance: '14 km', // Example distance
                    rating: '4.2', // Example rating
                    icon:
                        'assets/icons/madh_island.png', // Replace with your icon path
                    lat: "19.1865",
                    lon: "72.8233",
                  ),
                ],
              )
            ],
          ));
        }
        final result = _searchResults[index];
        return NearestSpotItem(
          name: result['display_name'] ?? '',
          distance:
              '${_calculateDistance(result['lat'], result['lon']).toStringAsFixed(0)} mi',
          rating: (result['place_rank'] ?? 0).toString(),
          icon: _getIconForType(result['type']),
          lat: result['lat'] ?? '0', // Extract latitude correctly
          lon: result['lon'] ?? '0', // Extract longitude correctly
        );
      },
    );
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/search?q=$query&format=json'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _searchResults =
              data.map((item) => item as Map<String, dynamic>).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while searching')),
      );
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchResults.clear();
    });
  }

  double _calculateDistance(String? lat, String? lon) {
    // Implement actual distance calculation here
    // For now, returning a mock distance
    return double.parse(lat ?? '0') + double.parse(lon ?? '0');
  }

  String _getIconForType(String? type) {
    // Map the type to an appropriate icon asset
    // This is a placeholder implementation
    switch (type) {
      case 'marina':
        return 'assets/icons/boat.png';
      case 'beach':
        return 'assets/icons/umbrella.png';
      default:
        return 'assets/icons/location.png';
    }
  }
}

class SearchBarUi extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback onClear;

  const SearchBarUi({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFF22445E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_back, color: Colors.white),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Beach, Ocean...',
                hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              onSubmitted: onSearch,
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: onClear,
          ),
          Icon(Icons.mic, color: Colors.white),
        ],
      ),
    );
  }
}

class TabBar extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;

  const TabBar({
    Key? key,
    required this.activeTab,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF00FEB5), width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTab('All'),
          _buildTab('Locations'),
          _buildTab('Weather stations'),
        ],
      ),
    );
  }

  Widget _buildTab(String title) {
    final isActive = activeTab == title;
    return GestureDetector(
      onTap: () => onTabChanged(title),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Color(0xFF00FEB5) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Color(0xFF00FEB5) : Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class NearestSpotItem extends StatelessWidget {
  final String name;
  final String distance;
  final String rating;
  final String icon;
  final String lat; // Latitude
  final String lon; // Longitude

  const NearestSpotItem({
    Key? key,
    required this.name,
    required this.distance,
    required this.rating,
    required this.icon,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(WeatherPage(lat: lat, lon: lon)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 14),
                      SizedBox(width: 4),
                      Text(
                        rating,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      SizedBox(width: 25),
                      Text(
                        distance,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 60,
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
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// class Weather extends StatefulWidget {
//   final String lat;  // Latitude
//   final String lon;  // Longitude

//   const Weather({Key? key, required this.lat, required this.lon}) : super(key: key);

//   @override
//   State<Weather> createState() => _WeatherState();
// }

// class _WeatherState extends State<Weather> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather Information'),
//       ),
//       body: Center(
//         child: Text(
//           'Latitude: ${widget.lat}\nLongitude: ${widget.lon}',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }



