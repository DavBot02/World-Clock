import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.max,
    required this.min,
    required this.date,
  });

  final double max;
  final double min;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              max.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5.0),
            Text(
              min.toString(),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
        const SizedBox(width: 10.0),
        Text(
          DateFormat.jm().format(date).toString(),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
