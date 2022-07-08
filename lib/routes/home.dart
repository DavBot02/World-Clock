import 'package:flutter/material.dart';
import 'package:one_app/views/city_card.dart';
import 'package:one_app/utils/city_data.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.favoriteLocations});
  final Set<CityData> favoriteLocations;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('World Time'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/set_fav_lovations');
            },
            tooltip: 'Saved Suggestions',
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            widget.favoriteLocations.isEmpty ? Colors.black : Colors.white,
      ),
      body: widget.favoriteLocations.isNotEmpty
          ? PageView(
              controller: controller,
              children: widget.favoriteLocations.map((location) {
                return CityCard(location: location);
              }).toList(),
            )
          : const Center(child: Text('Add a location!')),
    );
  }
}
