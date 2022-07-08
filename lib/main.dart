import 'package:flutter/material.dart';
import 'package:one_app/routes/home.dart';
import 'package:one_app/routes/set_fav_locations.dart';
import 'package:one_app/utils/city_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Set<CityData> favoriteLocations = <CityData>{};

  void updateFavoriteLocations(bool isFavorite, CityData toFavorite) {
    setState(() {
      if (!mounted) return;
      if (isFavorite) {
        favoriteLocations.remove(toFavorite);
      } else {
        favoriteLocations.add(toFavorite);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(
              favoriteLocations: favoriteLocations,
            ),
        '/set_fav_lovations': (context) => SetFavoriteLocations(
            favoriteLocations: favoriteLocations,
            updateFavoriteLocations: updateFavoriteLocations),
      },
    );
  }
}
