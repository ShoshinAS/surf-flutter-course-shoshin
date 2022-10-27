import 'package:places/data/model/place_type.dart';
import 'package:places/data/model/location.dart';

class Place {
  final String id;
  final Location location;
  final String name;
  final List<String> urls;
  final PlaceType placeType;
  final String description;

  String get coverURL => urls.isEmpty ? '' : urls[0];

  Place({
    required this.id,
    required this.name,
    required this.location,
    required this.urls,
    required this.description,
    required this.placeType,
  });

  @override
  String toString() => name;

}
