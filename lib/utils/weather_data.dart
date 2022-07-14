import './location_data.dart';

class WeatherData {
  WeatherData(
    this._city,
    this._time,
    this._isDayTime,
    this._weather,
    this._icon,
    this._temp,
    this._min,
    this._max,
    this._lon,
    this._lat,
    this._no2Concentration,
    this._lastUpdate,
    this._fiveDayForecast,
  );

  factory WeatherData.fromJson(
    String city,
    Map currentWeatherData,
    List<ForecastData> weatherForecastData,
    Map timeData,
    double airQualityData,
  ) {
    return WeatherData(
      city,
      timeData['time'],
      timeData['isDayTime'],
      currentWeatherData['weather'],
      currentWeatherData['icon'],
      currentWeatherData['temp'],
      currentWeatherData['min'],
      currentWeatherData['max'],
      currentWeatherData['lon'],
      currentWeatherData['lat'],
      airQualityData,
      DateTime.now(),
      weatherForecastData,
    );
  }

  final String _city;
  final String _time;
  final bool _isDayTime;
  final String _weather;
  final String _icon;
  final double _temp;
  final double _min;
  final double _max;
  final double _lon;
  final double _lat;
  final double _no2Concentration;
  DateTime _lastUpdate = DateTime.now();
  final List<ForecastData>? _fiveDayForecast;

  String get city => _city;
  String get time => _time;
  bool get isDayTime => _isDayTime;
  String get weather => _weather;
  String get icon => _icon;
  double get temp => _temp;
  double get min => _min;
  double get max => _max;
  double get lon => _lon;
  double get lat => _lat;
  double get no2Concentration => _no2Concentration;
  DateTime get lastUpdate => _lastUpdate;
  List<ForecastData>? get fiveDayForecast => _fiveDayForecast;
}
