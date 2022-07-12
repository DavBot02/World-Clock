import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './favorites_picker.dart';
import '../utils/favorite_locations.dart';
import '../views/location_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, FavoritesPicker.routeName);
            },
          ),
        ],
      ),
      body: Consumer<FavoriteLocations>(
        builder: (context, favoriteLocations, child) {
          return favoriteLocations.currentLocations.isNotEmpty
              ? PageView.builder(
                  itemBuilder: (context, index) {
                    return LocationCard(
                      location: favoriteLocations.currentLocations[index],
                    );
                  },
                  itemCount: favoriteLocations.currentLocations.length,
                )
              : const Center(child: Text('Add a location!'));
        },
      ),
    );
  }
}
