import 'package:mobx/mobx.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/user_data_repository.dart';

part 'places_store.g.dart';

class PlacesStore = PlacesStoreBase with _$PlacesStore;

abstract class PlacesStoreBase with Store {
  final PlaceRepository _placeRepository;
  final UserDataRepository _userDataRepository;

  @observable
  ObservableFuture<List<Place>>? placesFuture;

  @observable
  ObservableFuture<List<Place>>? favoritesFuture;

  PlacesStoreBase(this._placeRepository, this._userDataRepository);

  @action
  void getPlaces(Filter filter) {
    placesFuture = ObservableFuture(_sortedPlaces(filter));
  }

  @action
  void getFavorites() {
    favoritesFuture = ObservableFuture(_userDataRepository.getFavoritesPlaces());
  }

  @action
  void addToFavorites(Place place) {
    _userDataRepository.addToFavorites(place);
    getFavorites();
  }

  @action
  void removeFromFavorites(Place place) {
    _userDataRepository.removeFromFavorites(place);
    getFavorites();
  }

  Future<List<Place>> _sortedPlaces(Filter filter) async {
    final userLocation = filter.location;
    final places = await _placeRepository.getFilteredPlaces(filter);
    places.sort((a, b) => a.location
        .distanceToAnotherLocation(userLocation)
        .compareTo(b.location.distanceToAnotherLocation(userLocation)));

    return Future.value(places);
  }

}