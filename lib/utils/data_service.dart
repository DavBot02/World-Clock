import 'dart:convert';
import 'package:http/http.dart';

class DataService {
  String apiKey = '4bff35345ac2e30031ea2f22b88d7ff6';

  Future<Map> fetchCurrentWeatherData(String city) async {
    Response currentWeatherResponse = await get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey',
      ),
    );
    Map currentWeatherData = jsonDecode(currentWeatherResponse.body);
    return currentWeatherData;
  }

  Future<Map> fetchWeatherForecastData(double lat, double lon) async {
    Response weatherForecastResponse = await get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&cnt=&units=metric&appid=$apiKey',
      ),
    );
    Map weatherForecastData = jsonDecode(weatherForecastResponse.body);
    return weatherForecastData;
  }

  Future<Map> fetchTimeData(double lat, double lon) async {
    Response timeResponse = await get(
      Uri.parse(
        'https://timeapi.io/api/Time/current/coordinate?latitude=$lat&longitude=$lon',
      ),
    );
    Map timeData = jsonDecode(timeResponse.body);
    return timeData;
  }

  Future<Map> fetchAirQualityData(double lat, double lon) async {
    Response airQualityResponse = await get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey',
      ),
    );
    Map airQualityData = jsonDecode(airQualityResponse.body);
    return airQualityData;
  }
}
