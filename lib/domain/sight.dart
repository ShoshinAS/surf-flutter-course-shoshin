import 'package:places/domain/location.dart';
import 'package:places/domain/sight_type.dart';

class Sight {
  String name;
  Location location;
  List<String> imageURLs;
  String details;
  SightType type;

  String get coverURL => imageURLs.isEmpty ? '' : imageURLs[0];

  Sight({
    required this.name,
    required this.location,
    required this.imageURLs,
    required this.details,
    required this.type,
  });

  @override
  String toString() => name;
}
