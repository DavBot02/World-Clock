import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_app/utils/location_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationCard extends StatefulWidget {
  final LocationData location;
  const LocationCard({super.key, required this.location});

  @override
  State<LocationCard> createState() => _CityCardState();
}

class _CityCardState extends State<LocationCard> {
  Future<bool> _fetchLocationData() {
    return widget.location.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Forecast', 'Air pollution'];
    return FutureBuilder<bool>(
      future: _fetchLocationData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage((widget.location.isDayTime ?? true)
                    ? 'assets/day.jpg'
                    : 'assets/night.jpg'),
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
                                  '${widget.location.city} - ${widget.location.time ?? 'Loading'}',
                                  style: const TextStyle(
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  '${widget.location.temp.toString()}°C',
                                  style: const TextStyle(
                                    fontSize: 66.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'MIN: ${widget.location.min} - MAX: ${widget.location.max}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Image.network(widget.location.icon!),
                                Text(
                                  widget.location.weather!,
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
                    body: TabBarView(children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        widget.location.forecastData![index].max
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        widget.location.forecastData![index].min
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
                                        .format(widget
                                            .location.forecastData![index].date)
                                        .toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: widget.location.forecastData!.length),
                      Text('Hola'),
                    ]),
                  ),
                )),
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
