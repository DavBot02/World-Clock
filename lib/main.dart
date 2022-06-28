import 'package:flutter/material.dart';
import 'package:one_app/routes/home.dart';
import 'package:one_app/routes/set_fav_locations.dart';
import 'package:one_app/utils/location_time.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Set<LocationTime> favoriteLocations = <LocationTime>{};

  void updateFavoriteLocations(bool isFavorite, LocationTime toFavorite) {
    setState(() {
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
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
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
