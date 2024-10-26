import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class FeatureRichMap extends StatefulWidget {
  const FeatureRichMap({super.key});

  @override
  State<FeatureRichMap> createState() => _FeatureRichMapState();
}

class _FeatureRichMapState extends State<FeatureRichMap> with TickerProviderStateMixin {
  late final MapController _mapController;
  late final AnimationController _animationController;

  LatLng? _tappedLocation;
  final List<Marker> _markers = [];
  LatLng _currentCenter = const LatLng(19.0709, 72.8759);
  double _currentZoom = 13.0;

  // Predefined locations
  final Map<String, LatLng> _locations = {
  'Juhu Beach': LatLng(19.0937, 72.8258),      // Mumbai, India
  'Aksa Beach': LatLng(19.1974, 72.8221),      // Mumbai, India
  'Chopati Beach': LatLng(18.9656, 72.8234),    // Mumbai, India
  'Versova Beach': LatLng(19.1346, 72.8355),    // Mumbai, India
  'Madh Island': LatLng(19.1865, 72.8233), 
  };

  // Controller for search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Add initial markers for predefined locations
    _addPredefinedMarkers();
  }

  void _addPredefinedMarkers() {
    _locations.forEach((name, location) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: location,
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.location_on, color: Colors.red, size: 30),
                onPressed: () {
                  _showLocationInfo(name, location);
                },
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _addMarkerAtPosition(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: position,
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.place, color: Colors.blue),
                onPressed: () {
                  _showLocationInfo('Custom Location', position);
                },
              ),
              const Text(
                'Tapped',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showLocationInfo(String name, LatLng location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Latitude: ${location.latitude.toStringAsFixed(6)}'),
              Text('Longitude: ${location.longitude.toStringAsFixed(6)}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final url = Uri.parse(
                    'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}'
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: const Text('Open in Google Maps'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _animatedMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
      begin: _mapController.camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: _mapController.camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: _mapController.camera.zoom,
      end: destZoom,
    );

    Animation<double> animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    _animationController.addListener(() {
      _mapController.move(
        LatLng(
          latTween.evaluate(animation),
          lngTween.evaluate(animation),
        ),
        zoomTween.evaluate(animation),
      );
    });

    _animationController.forward(from: 0);
  }

  // Search for location
  void _searchLocation(String query) {
    if (_locations.containsKey(query)) {
      final location = _locations[query]!;
      _animatedMove(location, _currentZoom);
      setState(() {
        _tappedLocation = location;
        _addMarkerAtPosition(location);
      });
    } else {
      // Optionally, show an error message or handle not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$query not found')),
      );
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Map'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchLocation(_searchController.text);
                  },
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              final newZoom = _mapController.camera.zoom + 1;
              _animatedMove(_mapController.camera.center, newZoom);
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              final newZoom = _mapController.camera.zoom - 1;
              _animatedMove(_mapController.camera.center, newZoom);
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.location_city),
            onSelected: (String locationName) {
              final location = _locations[locationName];
              if (location != null) {
                _animatedMove(location, 13.0);
              }
            },
            itemBuilder: (BuildContext context) {
              return _locations.keys.map((String locationName) {
                return PopupMenuItem<String>(
                  value: locationName,
                  child: Text(locationName),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: _currentZoom,
              onTap: (_, point) {
                setState(() {
                  _tappedLocation = point;
                  _addMarkerAtPosition(point);
                });
              },
              onMapEvent: (MapEvent event) {
                if (event is MapEventMove) {
                  setState(() {
                    _currentCenter = event.camera.center;
                    _currentZoom = event.camera.zoom;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: _markers),
            ],
          ),
          if (_tappedLocation != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tapped Location:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Lat: ${_tappedLocation!.latitude.toStringAsFixed(6)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Lng: ${_tappedLocation!.longitude.toStringAsFixed(6)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _markers.clear();
                _addPredefinedMarkers();
                _tappedLocation = null;
              });
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              if (_tappedLocation != null) {
                _animatedMove(_tappedLocation!, 15.0);
              }
            },
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
