import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:one_app/utils/data_service.dart';
import 'package:one_app/utils/location_data.dart';
import 'package:one_app/utils/weather_data.dart';

import 'mock_data.dart';

class MockDataService extends Mock implements DataService {}

void main() {
  late MockDataService mockDataService;
  late LocationData locationData;

  setUp(() {
    mockDataService = MockDataService();
    locationData = LocationData('Tokyo', mockDataService);
  });

  test('initial values are correct', () {
    expect(locationData.city, 'Tokyo');
  });

  group('getArticles', () {
    void arrangeDataServiceReturnsMockCurrentWeatherData() {
      when(() => mockDataService.fetchCurrentWeatherData('Tokyo')).thenAnswer(
        (_) async => mockCurrentWeatherData,
      );
    }

    void arrangeDataServiceReturnsMockWeatherForecastData() {
      when(() => mockDataService.fetchWeatherForecastData(35.6895, 139.6917))
          .thenAnswer(
        (_) async => mockWeatherForecastData,
      );
    }

    void arrangeDataServiceReturnsMockTimeData() {
      when(() => mockDataService.fetchTimeData(35.6895, 139.6917)).thenAnswer(
        (_) async => mockTimeData,
      );
    }

    void arrangeDataServiceReturnsMockAirQualityData() {
      when(() => mockDataService.fetchAirQualityData(35.6895, 139.6917))
          .thenAnswer(
        (_) async => mockAirQualityData,
      );
    }

    test('gets weather data from data servie', () async {
      arrangeDataServiceReturnsMockCurrentWeatherData();
      arrangeDataServiceReturnsMockWeatherForecastData();
      arrangeDataServiceReturnsMockTimeData();
      arrangeDataServiceReturnsMockAirQualityData();

      await locationData.fetchData();
      verify(() => mockDataService.fetchCurrentWeatherData('Tokyo')).called(1);
    });

    test('sets correct data', () async {
      arrangeDataServiceReturnsMockCurrentWeatherData();
      arrangeDataServiceReturnsMockWeatherForecastData();
      arrangeDataServiceReturnsMockTimeData();
      arrangeDataServiceReturnsMockAirQualityData();

      WeatherData weatherData = await locationData.fetchData();
      expect(weatherData.isDayTime, true);
    });
  });
}
