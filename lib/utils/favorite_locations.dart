import 'dart:collection';
import 'package:flutter/material.dart';

import './location_data.dart';

class FavoriteLocations extends ChangeNotifier {
  final List<LocationData> _currentLocations = [];

  UnmodifiableListView<LocationData> get currentLocations =>
      UnmodifiableListView(_currentLocations);

  void addLocation(LocationData locationData) {
    _currentLocations.add(locationData);
    notifyListeners();
  }

  void removeLocation(LocationData locationData) {
    _currentLocations.remove(locationData);
    notifyListeners();
  }
}
