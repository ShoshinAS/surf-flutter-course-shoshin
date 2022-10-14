import 'package:places/data/model/place_type.dart';
import 'package:places/domain/location.dart';

class Filter {
  static const maxRadius = 30000.0;

  final Set<PlaceType> typeFilter;
  Location location;
  String nameFilter;
  double radius;

  Filter({
    required this.location,
  })  : radius = maxRadius,
        typeFilter = {},
        nameFilter = '';

  Filter.from(Filter filter)
      : location = filter.location,
        radius = filter.radius,
        nameFilter = filter.nameFilter,
        typeFilter = filter.typeFilter.toSet();

  void load(Filter filter) {
    location = filter.location;
    radius = filter.radius;
    typeFilter..clear()
    ..addAll(filter.typeFilter);
    nameFilter = filter.nameFilter;
  }

  bool typeSelected(PlaceType type) {
    return typeFilter.contains(type);
  }

  void invertTypeSelection(PlaceType type) {
    if (typeFilter.contains(type)) {
      typeFilter.remove(type);
    } else {
      typeFilter.add(type);
    }
  }

  void clear() {
    typeFilter.clear();
    radius = maxRadius;
  }
}
