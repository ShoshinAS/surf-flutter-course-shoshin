import 'dart:math';

class Location {
  final double latitude;
  final double longitude;

  Location(this.latitude, this.longitude);

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude}';
  }

  double distanceToAnotherLocation(Location anotherLocation){
    const ky = 40000 / 360;
    final kx = cos(pi * latitude / 180.0) * ky;
    final dx = ((longitude - anotherLocation.longitude) * kx).abs();
    final dy = ((latitude - anotherLocation.latitude) * ky).abs();

    return sqrt(dx * dx + dy * dy) * 1000;
  }

}
