import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractor {
  final PlaceRepository placeRepository;

  final List<Place> _favoritesPlaces;
  final List<Place> _visitedPlaces;

  PlaceInteractor(this.placeRepository)
      : _favoritesPlaces = [],
        _visitedPlaces = [];

  Future<List<Place>> getPlaces(Filter filter) async {
    final userLocation = filter.location;
    final places = await placeRepository.getFilteredPlaces(filter);
    places.sort((a, b) => a.location
        .distanceToAnotherLocation(userLocation)
        .compareTo(b.location.distanceToAnotherLocation(userLocation)));

    return Future.value(places);
  }

  Future<Place> getPlaceDetails(String id) async {
    return placeRepository.getPlace(id);
  }

  Future<List<Place>> getFavoritesPlaces() async {
    return Future.value(_favoritesPlaces);
  }

  Future<void> addToFavorites(Place place) async {
    _favoritesPlaces.add(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    _favoritesPlaces.removeWhere((element) => element.id == place.id);
  }

  Future<void> moveOnFavorites(Place sourcePlace, Place? targetPlace) async {
    _favoritesPlaces.removeWhere((element) => element.id == sourcePlace.id);
    if (targetPlace != null) {
      final targetIndex = _favoritesPlaces.indexWhere((element) => element.id == targetPlace.id);
      _favoritesPlaces.insert(targetIndex, sourcePlace);
    } else {
      _favoritesPlaces.add(sourcePlace);
    }
  }

  Future<List<Place>> getVisitPlaces() async {
    return _visitedPlaces;
  }

  Future<void> addToVisitingPlaces(Place place) async {
    _visitedPlaces.add(place);
  }

  Future<Place> addNewPlace(Place place) async {
    return placeRepository.addPlace(place);
  }
}
