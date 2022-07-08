import 'dart:collection';
import 'package:flutter/material.dart';
import 'location_data.dart';

class FavoriteLocations extends ChangeNotifier {
  final Set<LocationData> _currentLocations = {};

  UnmodifiableSetView<LocationData> get currentLocations =>
      UnmodifiableSetView(_currentLocations);

  void addLocation(LocationData locationTime) {
    _currentLocations.add(locationTime);
    notifyListeners();
  }

  void removeLocation(LocationData locationTime) {
    _currentLocations.remove(locationTime);
    notifyListeners();
  }
}
