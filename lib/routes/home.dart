import 'package:flutter/material.dart';
import 'package:one_app/views/location.dart';
import 'package:one_app/utils/location_time.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.favoriteLocations});
  final Set<LocationTime> favoriteLocations;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _pushSaved() {
    Navigator.pushNamed(context, '/set_fav_lovations');
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("World Time"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: widget.favoriteLocations.isNotEmpty
          ? PageView(
              controller: controller,
              children: widget.favoriteLocations.map((location) {
                return Location(location: location);
              }).toList(),
            )
          : const Center(child: Text("Add a location!")),
    );
  }
}
