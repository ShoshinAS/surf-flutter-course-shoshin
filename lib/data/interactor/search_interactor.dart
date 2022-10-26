import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class SearchInteractor {
  final PlaceRepository placeRepository;

  final List<String> _history;

  SearchInteractor(this.placeRepository) : _history = [];

  Future<List<String>> getHistory() async {
    return Future.value(_history);
  }

  Future<void> clearHistory() async {
    _history.clear();
  }

  Future<List<Place>> searchPlaces(Filter filter) async {
    if (filter.nameFilter.isEmpty) {
      return Future.value(<Place>[]);
    }
    _history
      ..remove(filter.nameFilter)
      ..insert(0, filter.nameFilter);

    return placeRepository.getFilteredPlaces(filter);
  }

  Future<void> removeFromHistory(String query) async {
    _history.remove(query);
  }

}