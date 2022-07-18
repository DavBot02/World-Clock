import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/all_locations.dart';
import '../utils/favorite_locations.dart';
import '../utils/location_data.dart';
import 'home.dart';

class FavoritesPicker extends StatefulWidget {
  const FavoritesPicker({super.key});

  static const String routeName = 'favorites_picker';

  @override
  State<FavoritesPicker> createState() => _SetFavoriteLocationsState();
}

class _SetFavoriteLocationsState extends State<FavoritesPicker> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // Returns to the homepage when the user overscrolls
        if (notification.metrics.pixels > notification.metrics.maxScrollExtent + 100 &&
            mounted) {
          Navigator.popUntil(context, ModalRoute.withName(Home.routeName));
        }
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Select favorite cities'),
              ),
            ),
            Consumer<FavoriteLocations>(
              builder: (context, favoriteLocations, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      LocationData location = allLocations[index];
                      bool isFavorite =
                          favoriteLocations.currentLocations.contains(location);
                      return ListTile(
                        title: Text(location.city),
                        trailing: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onTap: () {
                          if (isFavorite) {
                            favoriteLocations.removeLocation(location);
                          } else {
                            favoriteLocations.addLocation(location);
                          }
                        },
                      );
                    },
                    childCount: allLocations.length,
                  ),
                );
              },
            )
          ],
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
