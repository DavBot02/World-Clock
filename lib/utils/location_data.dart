import 'package:http/http.dart';
import 'dart:convert';

class ForecastData {
  ForecastData({required this.max, required this.min, required this.date});

  double max;
  double min;
  DateTime date;
}

class LocationData {
  LocationData({required this.city});

  String city;
  String? time;
  bool? isDayTime;
  String? weather;
  String? icon;
  double? temp;
  double? min;
  double? max;
  double? lon;
  double? lat;
  double? no2Concentration;
  DateTime lastUpdate = DateTime.now();
  List<ForecastData>? forecastData;

  Future<bool> fetchData() async {
    lastUpdate = DateTime.now();

    String apikey = '4bff35345ac2e30031ea2f22b88d7ff6';
    Response currentWeatherResponse = await get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apikey',
      ),
    );
    Map currentWeatherData = jsonDecode(currentWeatherResponse.body);
    String iconCode = currentWeatherData['weather'][0]['icon'];

    weather = currentWeatherData['weather'][0]['main'];
    icon = 'https://openweathermap.org/img/wn/$iconCode@2x.png';
    temp = currentWeatherData['main']['temp'].toDouble();
    min = currentWeatherData['main']['temp_min'].toDouble();
    max = currentWeatherData['main']['temp_max'].toDouble();
    lon = currentWeatherData['coord']['lon'].toDouble();
    lat = currentWeatherData['coord']['lat'].toDouble();

    Response futureWeatherResponse = await get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&cnt=&units=metric&appid=$apikey',
      ),
    );
    Map futureWeatherData = jsonDecode(futureWeatherResponse.body);

    forecastData = futureWeatherData['list'].map<ForecastData>((day) {
      return ForecastData(
        max: day['main']['temp_max'].toDouble(),
        min: day['main']['temp_min'].toDouble(),
        date: DateTime.parse(day['dt_txt']),
      );
    }).toList();

    Response timeResponse = await get(
      Uri.parse(
        'https://timeapi.io/api/Time/current/coordinate?latitude=$lat&longitude=$lon',
      ),
    );
    Map timeData = jsonDecode(timeResponse.body);
    time = timeData['time'];
    isDayTime = timeData['hour'] > 6 && timeData['hour'] < 20 ? true : false;

    Response airQualityResponse = await get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apikey',
      ),
    );
    Map airQualityData = jsonDecode(airQualityResponse.body);
    no2Concentration = airQualityData['list'][0]['components']['no'];
    return true;
  }
}
