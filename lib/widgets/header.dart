import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.city,
    required this.time,
    required this.temp,
    required this.min,
    required this.max,
    required this.icon,
    required this.weather,
  });

  final String city;
  final String time;
  final double temp;
  final double min;
  final double max;
  final String icon;
  final String weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50.0),
        Text(
          '$city - $time',
          style: const TextStyle(
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          '${temp.toString()}°C',
          style: const TextStyle(
            fontSize: 66.0,
            color: Colors.white,
          ),
        ),
        Text(
          'MIN: $min - MAX: $max',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Image.network(icon),
        Text(
          weather,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
