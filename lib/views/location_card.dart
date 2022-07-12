import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/location_data.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key, required this.location});

  final LocationData location;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  Future<bool> _fetchLocationData() {
    return widget.location.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _fetchLocationData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    (widget.location.isDayTime ?? true)
                        ? 'assets/day.jpg'
                        : 'assets/night.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.location.location,
                          style: const TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    widget.location.time != null
                        ? Text(
                            widget.location.time ?? '',
                            style: TextStyle(
                              fontSize: 66.0,
                              color: Colors.white,
                            ),
                          )
                        : const SpinKitSpinningLines(
                            color: Colors.blue,
                            size: 80.0,
                          ),
                    Expanded(
                      child: Center(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Day of the week: ${widget.location.dayOfWeek.toString()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                'Day of the year: ${widget.location.dayOfyear.toString()}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                'Unix time: ${widget.location.unixTime.toString()}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                'Week number: ${widget.location.weekNumber.toString()}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: const Text('There has been an error!'));
        } else {
          return Center(child: const Text('Waiting for data...'));
        }
      },
    );
  }
}
