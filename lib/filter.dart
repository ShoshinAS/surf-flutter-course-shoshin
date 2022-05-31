import 'package:geolocator/geolocator.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type.dart';

class Filter {
  final List<Sight> sightList;

  Set<SightType> selectedCategories;
  double startDistance;
  double endDistance;
  List<Sight> result = [];
  Location? _currentLocation;

  Filter(
      {required this.sightList,
      this.startDistance = 0,
      this.endDistance = 0,
      this.selectedCategories = const {},});

  void clear(){
    selectedCategories = SightType.values.toSet();
  }

  void invert(SightType category){
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  bool selected(SightType category){
    return selectedCategories.contains(category);
  }

  void filter() {
    result.clear();

    for (final sight in sightList) {
      if (!selectedCategories.contains(sight.type)) {
        continue;
      }
      if (_currentLocation != null) {
        final distance =
            _currentLocation!.distanceToAnotherLocation(sight.location);
        if (distance < startDistance || distance > endDistance) {
          continue;
        }
      }
      result.add(sight);
    }
  }

  Future<void> determineCurrentLocation() async {
    _currentLocation = Location.fromPosition(await _determinePosition());
  }

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.',);
    }

    return Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  }
}
