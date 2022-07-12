import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/favorite_locations.dart';
import '../utils/all_locations.dart';

class SetFavoriteLocations extends StatelessWidget {
  const SetFavoriteLocations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select favorite locations'),
      ),
      body: Consumer<FavoriteLocations>(
        builder: (context, favoriteLocations, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: allLocations.length,
            itemBuilder: (context, index) {
              bool isFavorite = favoriteLocations.currentLocations
                  .contains(allLocations[index]);
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
                  if (isFavorite) {
                    favoriteLocations.removeLocation(allLocations[index]);
                  } else {
                    favoriteLocations.addLocation(allLocations[index]);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
