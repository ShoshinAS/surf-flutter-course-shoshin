import 'package:places/domain/location.dart';
import 'package:places/domain/sight_type.dart';

class Sight {
  String id;
  String name;
  Location location;
  List<String> imageURLs;
  String details;
  SightType type;

  String get coverURL => imageURLs.isEmpty ? '' : imageURLs[0];

  Sight({
    required this.id,
    required this.name,
    required this.location,
    required this.imageURLs,
    required this.details,
    required this.type,
  });

  @override
  String toString() => name;
}
