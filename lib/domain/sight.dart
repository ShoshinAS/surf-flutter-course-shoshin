import 'package:places/domain/location.dart';
import 'package:places/domain/sight_type.dart';

class Sight {
  String name;
  Location location;
  String url;
  String details;
  SightType type;

  Sight({
    required this.name,
    required this.location,
    required this.url,
    required this.details,
    required this.type,
  });

  @override
  String toString() => name;
}
