import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

const String API_KEY = weatherAPI;
const String _cityName = "Peshawar";
const String WEATHER_API_URL =
    "https://api.openweathermap.org/data/2.5/weather?q=$_cityName,pk&appid=$API_KEY&units=metric";

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  String cityname = _cityName;
  String _weatherDescription = "Loading...";
  int _temperature = 0;
  String _iconUrl = "";
  late Timer _timer;

  Future<void> _getWeatherData() async {
    final response = await http.get(Uri.parse(WEATHER_API_URL));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        cityname = data["name"];
        _weatherDescription = data["weather"][0]["description"];
        _temperature = data["main"]["temp"].round();
        _iconUrl =
            "https://openweathermap.org/img/w/${data["weather"][0]["icon"]}.png";
      });
    } else {
      setState(() {
        _weatherDescription = "Failed to load weather data";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getWeatherData();
    _timer = Timer.periodic(Duration(hours: 1), (Timer t) => _getWeatherData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_cityName} Weather'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(_iconUrl),
              Text(
                '$_temperature°C',
                style: TextStyle(fontSize: 48.0),
              ),
              Text(
                '$_weatherDescription',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
