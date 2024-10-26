import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:saarhti/util/constants/imageStrings_constant.dart';

class WeatherPage extends StatefulWidget {
  final String lat;
  final String lon;

  const WeatherPage({Key? key, required this.lat, required this.lon}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? weatherData;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<DateTime> availableDates = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    _initializeDates();
  }

  void _initializeDates() {
    availableDates = List.generate(3, (index) => DateTime.now().add(Duration(days: index)));
  }

  Future<void> fetchWeatherData() async {
    final weatherUrl =
        'https://api.open-meteo.com/v1/forecast?latitude=${widget.lat}&longitude=${widget.lon}&hourly=relative_humidity_2m,precipitation_probability,precipitation,wind_speed_180m,wind_direction_120m,temperature_180m,soil_temperature_54cm,soil_moisture_27_to_81cm&forecast_days=3&timezone=GMT';

    try {
      final response = await http.get(Uri.parse(weatherUrl));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: weatherData == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDateSelector(),
                        SizedBox(height: 16),
                        _buildLocationInfo(),
                        SizedBox(height: 16),
                        _buildHourlyDataSection('Hourly Weather Data', weatherData!['hourly']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Weather Forecast', style: TextStyle(color: Colors.white)),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              xImageStrings.mapgif,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableDates.length,
        itemBuilder: (context, index) {
          final date = availableDates[index];
          final isSelected = date.day == selectedDate.day;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 8),
                Text('Coordinates: ${widget.lat}, ${widget.lon}',overflow: TextOverflow.ellipsis,),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.height, color: Colors.blue),
                SizedBox(width: 8),
                Text('Elevation: ${weatherData!['elevation'] ?? 'N/A'} m'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyDataSection(String title, Map<String, dynamic> hourlyData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 24,
            itemBuilder: (context, index) {
              return _buildHourlyWeatherCard(hourlyData, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyWeatherCard(Map<String, dynamic> hourlyData, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(right: 16, bottom: 8),
      child: Container(
        width: 120,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              DateFormat('HH:mm').format(DateTime.parse(hourlyData['time'][index])),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.cloud, size: 32, color: Colors.blue),
            Text('${hourlyData['temperature_180m'][index]}°C', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('${hourlyData['precipitation_probability'][index]}%', style: TextStyle(color: Colors.blue)),
            Text('${hourlyData['wind_speed_180m'][index]} m/s', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}