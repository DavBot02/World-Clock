import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/location_data.dart';
import '../utils/weather_data.dart';
import '../widgets/forecast_card.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({
    super.key,
    required this.location,
  });

  final LocationData location;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  late Future<WeatherData> _weatherData;

  @override
  void initState() {
    _weatherData = widget.location.fetchData();
    super.initState();
  }

  String _airQuality(double no2Concentration) {
    if (no2Concentration > 400) {
      return 'Very poor';
    } else if (no2Concentration > 200) {
      return 'Poor';
    } else if (no2Concentration > 100) {
      return 'Moderate';
    } else if (no2Concentration > 50) {
      return 'Fair';
    } else {
      return 'Good';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Forecast', 'Air quality'];
    return FutureBuilder<WeatherData>(
      future: _weatherData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  (snapshot.data!.isDayTime)
                      ? 'assets/day.jpg'
                      : 'assets/night.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
              child: DefaultTabController(
                length: tabs.length,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            children: [
                              const SizedBox(height: 50.0),
                              Text(
                                '${snapshot.data!.city} - ${snapshot.data!.time}',
                                style: const TextStyle(
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                '${snapshot.data!.temp.toString()}°C',
                                style: const TextStyle(
                                  fontSize: 66.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'MIN: ${snapshot.data!.min} - MAX: ${snapshot.data!.max}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Image.network(snapshot.data!.icon),
                              Text(
                                snapshot.data!.weather,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 30.0),
                            ],
                          ),
                          TabBar(
                            tabs: tabs
                                .map((String name) => Tab(text: name))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ]),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0.0,
                              vertical: 10.0,
                            ),
                            child: ForecastCard(
                              max: snapshot.data!.fiveDayForecast![index].max,
                              min: snapshot.data!.fiveDayForecast![index].min,
                              date: snapshot.data!.fiveDayForecast![index].date,
                            ),
                          );
                        },
                        itemCount: snapshot.data!.fiveDayForecast!.length,
                      ),
                      Center(
                        child: Text(
                          _airQuality(snapshot.data!.no2Concentration),
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error has ocurred!'));
        } else {
          return const SpinKitSpinningLines(
            color: Colors.blue,
            size: 80.0,
          );
        }
      },
    );
  }
}
