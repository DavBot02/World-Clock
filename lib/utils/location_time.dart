import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class LocationTime {
  String location;
  String url;
  String? time;
  int? dayOfWeek;
  int? dayOfyear;
  int? unixTime;
  int? weekNumber;
  bool? isDayTime;

  LocationTime({required this.location, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String utcOffset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = data['utc_offset'].substring(0, 1) == "+"
          ? now.add(Duration(hours: int.parse(utcOffset)))
          : now.subtract(Duration(hours: int.parse(utcOffset)));
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      dayOfWeek = data['day_of_week'];
      dayOfyear = data['day_of_year'];
      unixTime = data['unixtime'];
      weekNumber = data['week_number'];
      time = DateFormat.jm().format(now);
    } catch (error) {
      time = "could not get time data";
      throw FormatException('caught error: $error');
    }
  }
}
