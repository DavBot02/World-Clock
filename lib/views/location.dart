import 'package:flutter/material.dart';
import 'package:one_app/utils/location_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Location extends StatefulWidget {
  final LocationTime location;
  const Location({super.key, required this.location});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  void setUpTime() async {
    await widget.location.getTime();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    setUpTime();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage((widget.location.isDayTime ?? true)
                ? "assets/day.jpg"
                : "assets/night.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.location.location,
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: (widget.location.isDayTime ?? true)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              widget.location.time != null
                  ? Text(
                      widget.location.time ?? "",
                      style: TextStyle(
                        fontSize: 66.0,
                        color: (widget.location.isDayTime ?? true)
                            ? Colors.black
                            : Colors.white,
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
                                'Day of the week: ${widget.location.dayOfWeek.toString()}')),
                      ),
                      Container(
                          width: 200,
                          child: Text(
                              'Day of the year: ${widget.location.dayOfyear.toString()}')),
                      Container(
                          width: 200,
                          child: Text(
                              'Unix time: ${widget.location.unixTime.toString()}')),
                      Container(
                          width: 200,
                          child: Text(
                              'Week number: ${widget.location.weekNumber.toString()}')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
