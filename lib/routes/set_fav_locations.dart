import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:one_app/utils/all_locations.dart';
import 'package:one_app/utils/city_data.dart';
import 'package:flutter/services.dart' show rootBundle;

class SetFavoriteLocations extends StatefulWidget {
  const SetFavoriteLocations(
      {super.key,
      required this.favoriteLocations,
      required this.updateFavoriteLocations});

  final Set<CityData> favoriteLocations;
  final Function updateFavoriteLocations;

  @override
  State<SetFavoriteLocations> createState() => _SetFavoriteLocationsState();
}

class _SetFavoriteLocationsState extends State<SetFavoriteLocations> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent &&
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
              backgroundColor: Colors.blue,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Select favorite cities'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  bool isFavorite =
                      widget.favoriteLocations.contains(allLocations[index]);
                  return ListTile(
                    title: Text(
                      allLocations[index].city,
                    ),
                    trailing: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onTap: () {
                      widget.updateFavoriteLocations(
                          isFavorite, allLocations[index]);
                    },
                  );
                },
                childCount: allLocations.length,
              ),
            )
          ],
          // physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

loadAllLocations() async {
  Future<String> getJson() {
    return rootBundle.loadString('assets/citylist.json');
  }

  final allLocations = jsonDecode(await getJson()).map(((location) {
    return location.name;
  }));
  return allLocations;
}
