import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/favorite_locations.dart';
import '../utils/all_locations.dart';

class SetFavoriteLocations extends StatefulWidget {
  const SetFavoriteLocations({super.key});

  @override
  State<SetFavoriteLocations> createState() => _SetFavoriteLocationsState();
}

class _SetFavoriteLocationsState extends State<SetFavoriteLocations> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >
                notification.metrics.maxScrollExtent + 100 &&
            mounted) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
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
              builder: ((context, favoriteLocations, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      bool isFavorite = favoriteLocations.currentLocations
                          .contains(allLocations[index]);
                      return ListTile(
                        title: Text(
                          allLocations[index].city,
                        ),
                        trailing: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onTap: () {
                          if (isFavorite) {
                            favoriteLocations
                                .removeLocation(allLocations[index]);
                          } else {
                            favoriteLocations.addLocation(allLocations[index]);
                          }
                        },
                      );
                    },
                    childCount: allLocations.length,
                  ),
                );
              }),
            )
          ],
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}