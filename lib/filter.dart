import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/mocks.dart';

class Filter {
  final double maxDistance;
  final List<Sight> sightList;
  final Location _currentLocation = MockLocations.location2;

  set selectedDistance(double value) {
    _selectedDistance = value;
    _filter();
  }

  double get selectedDistance => _selectedDistance;

  List<Sight> get result => _result;

  set selectedCategories(Set<SightType> value) {
    _selectedCategories = value;
    _filter();
  }

  Set<SightType> get selectedCategories => _selectedCategories;

  int get amount => _result.length;


  Set<SightType> _selectedCategories;
  double _selectedDistance;
  List<Sight> _result;

  Filter({
    required this.sightList,
    required this.maxDistance,
  })  : _selectedDistance = maxDistance,
        _selectedCategories = {},
        _result = []
  {
    _filter();
  }

  void clear() {
    _selectedCategories.clear();
    _selectedDistance = maxDistance;
    _filter();
  }

  void invert(SightType category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _filter();
  }

  bool selected(SightType category) {
    return _selectedCategories.contains(category);
  }

  void _filter() {
    _result.clear();

    for (final sight in sightList) {
      if (_selectedCategories.isNotEmpty &
          !_selectedCategories.contains(sight.type)) {
        continue;
      }
      final distance =
          _currentLocation.distanceToAnotherLocation(sight.location);
      if (distance > _selectedDistance) {
        continue;
      }
      _result.add(sight);
    }
  }
}
