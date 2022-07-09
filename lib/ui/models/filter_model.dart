import 'package:flutter/foundation.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/mocks.dart';

// класс реализует фильтр для отбора интересных мест из спика
// по расстоянию от текущего местоположения и категориям
class Filter extends ChangeNotifier {
  final double maxDistance;
  final Location _currentLocation = MockLocations.location1;
  final List<Sight> _sightList;
  final List<Sight> _result;
  final Set<SightType> _selectedCategories;

  set selectedDistance(double value) {
    _selectedDistance = value;
    _filter();
  }

  double get selectedDistance => _selectedDistance;
  List<Sight> get sightList => _sightList;
  List<Sight> get result => _result;
  Set<SightType> get selectedCategories => _selectedCategories;
  int get amount => _result.length;

  double _selectedDistance;

  Filter({
    required this.maxDistance,
    required List<Sight> sightList,
  })  : _sightList = sightList,
        _selectedDistance = maxDistance,
        _selectedCategories = {},
        _result = [] {
    _filter();
  }

  Filter.from(Filter filter) :
        maxDistance = filter.maxDistance,
        _sightList = filter._sightList,
        _selectedDistance = filter._selectedDistance,
        _selectedCategories = {},
        _result = [] {
    _selectedCategories.addAll(filter._selectedCategories);
    _result.addAll(filter._result);
  }

  void fill(Filter filter) {
    _selectedDistance = filter._selectedDistance;
    _selectedCategories..clear()
    ..addAll(filter._selectedCategories);
    _filter();
  }

  void addSight(Sight sight) {
    _sightList.add(sight);
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

    for (final sight in _sightList) {
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
    notifyListeners();
  }
}
