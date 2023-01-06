import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/user_data_repository.dart';

class PlaceInteractor {
  final PlaceRepository placeRepository;
  final UserDataRepository userDataRepository;

  PlaceInteractor(this.placeRepository, this.userDataRepository);

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
    return userDataRepository.getFavoritesPlaces();
  }

  Future<void> addToFavorites(Place place) async {
    return userDataRepository.addToFavorites(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    await userDataRepository.removeFromFavorites(place);
  }
  
  Future<List<Place>> getVisitPlaces() async {
    return userDataRepository.getVisitedPlaces();
  }

  Future<void> addToVisitingPlaces(Place place) async {
    await userDataRepository.addToVisitedPlaces(place);
  }

  Future<Place> addNewPlace(Place place) async {
    return placeRepository.addPlace(place);
  }
}
