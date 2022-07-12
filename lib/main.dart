import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/home.dart';
import 'routes/set_favorite_locations.dart';
import 'routes/route_names.dart';
import 'utils/favorite_locations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteLocations(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
        initialRoute: '/',
        routes: {
          root: (context) => Home(),
          setFavoriteLocations: (context) => SetFavoriteLocations(),
        },
      ),
    );
  }
}
