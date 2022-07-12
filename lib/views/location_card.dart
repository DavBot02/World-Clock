import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/location_data.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.location,
  });

  final LocationData location;

  Future<bool> _fetchLocationData() {
    return location.fetchData();
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
    return FutureBuilder<bool>(
      future: _fetchLocationData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  (location.isDayTime ?? true)
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
                                '${location.city} - ${location.time ?? 'Loading'}',
                                style: const TextStyle(
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                '${location.temp.toString()}°C',
                                style: const TextStyle(
                                  fontSize: 66.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'MIN: ${location.min} - MAX: ${location.max}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Image.network(location.icon!),
                              Text(
                                location.weather!,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      location.forecastData![index].max
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      location.forecastData![index].min
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 5.0),
                                  ],
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  DateFormat.jm()
                                      .format(
                                        location.forecastData![index].date,
                                      )
                                      .toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: location.forecastData!.length,
                      ),
                      Center(
                        child: Text(
                          _airQuality(location.no2Concentration!),
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
