import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './route_names.dart';
import '../utils/favorite_locations.dart';
import '../views/location_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Time'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, setFavoriteLocations);
            },
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: Consumer<FavoriteLocations>(
        builder: (context, favoriteLocations, child) {
          return favoriteLocations.currentLocations.isNotEmpty
              ? PageView(
                  children: favoriteLocations.currentLocations
                      .map(
                        (location) => LocationCard(location: location),
                      )
                      .toList(),
                )
              : const Center(child: Text('Add a location!'));
        },
      ),
    );
  }
}
