import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = '033511f1161ec331a3c53e4b02444913';
  String city = '';
  String temperature = '';
  String description = '';
  String weatherIcon = 'lib/Assets/cloudy.png';
  String weatherText = '';
  bool isLoading = false;
  String errorMessage = '';
  String humidity = '';
  String windSpeed = '';
  String dateTime = '';

  @override
  void initState() {
    super.initState();
    refreshWeather(); // Fetch weather data when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,

      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.greenAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      city = value;
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.location_city, color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (city.isNotEmpty) {
                      fetchWeather();
                    } else {
                      setState(() {
                        errorMessage = 'Please enter a city';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Get Weather'),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  CircularProgressIndicator()
                else if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                else if (temperature.isNotEmpty)
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Temperature: $temperature °C',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Weather: $description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Condition: $weatherText',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Humidity: $humidity%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Wind Speed: $windSpeed m/s',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Date and Time:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          dateTime,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            refreshWeather();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Refresh'),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          temperature = (data['main']['temp'] - 273.15).toStringAsFixed(2);
          description = data['weather'][0]['description'];
          humidity = data['main']['humidity'].toString();
          windSpeed = data['wind']['speed'].toString();

          if (double.parse(temperature) > 30) {
            weatherIcon = 'lib/Assets/hot.png';
            weatherText = 'Hot';
          } else if (double.parse(temperature) >= 20 &&
              double.parse(temperature) <= 30) {
            weatherIcon = 'lib/Assets/warm.png';
            weatherText = 'Warm';
          } else if (double.parse(temperature) >= 10 &&
              double.parse(temperature) < 20) {
            weatherIcon = 'lib/Assets/mild.png';
            weatherText = 'Mild';
          } else if (double.parse(temperature) >= 0 &&
              double.parse(temperature) < 10) {
            weatherIcon = 'lib/Assets/cool.png';
            weatherText = 'Cool';
          } else {
            weatherIcon = 'lib/Assets/cold.png';
            weatherText = 'Cold';
          }

          final DateTime now = DateTime.now();
          dateTime = _formatDateTime(now);
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching weather data';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void refreshWeather() {
    if (city.isNotEmpty) {
      fetchWeather();
    } else {
      setState(() {
        errorMessage = 'Please enter a city';
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final dayOfWeek = _getDayOfWeek(dateTime.weekday);
    final month = _getMonth(dateTime.month);
    return '$dayOfWeek, $month ${dateTime.day}, ${dateTime.year} ${_formatTime(dateTime)}';
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dateTime.minute}:${dateTime.second} $period';
  }
}
