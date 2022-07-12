import 'package:one_app/utils/data_service.dart';
import 'package:test/test.dart';
import '../lib/utils/favorite_locations.dart';
import '../lib/utils/location_data.dart';

void main() {
  test('element should be added to set', () {
    final favoriteLocations = FavoriteLocations();
    final dataService = DataService();
    final locationData = LocationData('New York', dataService);

    favoriteLocations.addLocation(locationData);

    expect(favoriteLocations.currentLocations.contains(locationData), true);
  });
}
