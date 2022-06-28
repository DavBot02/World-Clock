import 'package:flutter/material.dart';
import 'package:one_app/utils/all_locations.dart';
import 'package:one_app/utils/location_time.dart';

class SetFavoriteLocations extends StatelessWidget {
  const SetFavoriteLocations(
      {super.key,
      required this.favoriteLocations,
      required this.updateFavoriteLocations});

  final Set<LocationTime> favoriteLocations;
  final Function updateFavoriteLocations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Favorite Locations'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: allLocations.length,
        itemBuilder: (context, index) {
          bool isFavorite = favoriteLocations.contains(allLocations[index]);
          return ListTile(
            title: Text(
              allLocations[index].location,
            ),
            trailing: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
              semanticLabel: isFavorite ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              updateFavoriteLocations(isFavorite, allLocations[index]);
            },
          );
        },
      ),
    );
  }
}
