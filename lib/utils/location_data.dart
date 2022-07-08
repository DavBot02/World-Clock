import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class LocationData {
  LocationData({required this.location, required this.url});

  String location;
  String url;
  String? time;
  int? dayOfWeek;
  int? dayOfyear;
  int? unixTime;
  int? weekNumber;
  bool? isDayTime;

  Future<bool> fetchData() async {
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);

    String datetime = data['datetime'];
    String utcOffset = data['utc_offset'].substring(1, 3);

    DateTime now = DateTime.parse(datetime);

    now = data['utc_offset'].substring(0, 1) == '+'
        ? now.add(Duration(hours: int.parse(utcOffset)))
        : now.subtract(Duration(hours: int.parse(utcOffset)));
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    dayOfWeek = data['day_of_week'];
    dayOfyear = data['day_of_year'];
    unixTime = data['unixtime'];
    weekNumber = data['week_number'];
    time = DateFormat.jm().format(now);

    return true;
  }
}
