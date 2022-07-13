import './data_service.dart';
import './weather_data.dart';

class ForecastData {
  ForecastData({
    required this.max,
    required this.min,
    required this.date,
  });

  double max;
  double min;
  DateTime date;
}

class LocationData {
  LocationData(
    this._city,
    this._dataService,
  );

  final String _city;
  final DataService _dataService;

  String get city => _city;

  Map _formatCurrentWeatherData(Map currentWeatherData) {
    String iconCode = currentWeatherData['weather'][0]['icon'];

    return {
      'weather': currentWeatherData['weather'][0]['main'],
      'icon': 'https://openweathermap.org/img/wn/$iconCode@2x.png',
      'temp': currentWeatherData['main']['temp'].toDouble(),
      'min': currentWeatherData['main']['temp_min'].toDouble(),
      'max': currentWeatherData['main']['temp_max'].toDouble(),
      'lon': currentWeatherData['coord']['lon'].toDouble(),
      'lat': currentWeatherData['coord']['lat'].toDouble()
    };
  }

  List<ForecastData> _formatWeatherForecastData(Map weatherForecastData) {
    return weatherForecastData['list'].map<ForecastData>((day) {
      return ForecastData(
        max: day['main']['temp_max'].toDouble(),
        min: day['main']['temp_min'].toDouble(),
        date: DateTime.parse(day['dt_txt']),
      );
    }).toList();
  }

  double _formatAirQualityData(Map airQualityData) {
    return airQualityData['list'][0]['components']['no'].toDouble();
  }

  Map _formatTimeData(Map timeData) {
    return {
      'time': timeData['time'],
      'isDayTime': timeData['hour'] > 6 && timeData['hour'] < 20 ? true : false,
    };
  }

  Future<WeatherData> fetchData() async {
    Map currentWeatherData = await _dataService.fetchCurrentWeatherData(_city);
    double lon = currentWeatherData['coord']['lon'].toDouble();
    double lat = currentWeatherData['coord']['lat'].toDouble();
    Map formattedCurrentWeatherData =
        _formatCurrentWeatherData(currentWeatherData);

    Map weatherForecastData =
        await _dataService.fetchWeatherForecastData(lat, lon);
    List<ForecastData> formattedWeatherForecastData =
        _formatWeatherForecastData(weatherForecastData);

    Map airQualityData = await _dataService.fetchAirQualityData(lat, lon);
    double formattedAirQualityData = _formatAirQualityData(airQualityData);

    Map timeData = await _dataService.fetchTimeData(lat, lon);
    Map formattedTimeData = _formatTimeData(timeData);

    return WeatherData.fromJson(
      _city,
      formattedCurrentWeatherData,
      formattedWeatherForecastData,
      formattedTimeData,
      formattedAirQualityData,
    );
  }
}
