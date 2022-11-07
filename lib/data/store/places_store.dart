import 'package:mobx/mobx.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

part 'places_store.g.dart';

class PlacesStore = PlacesStoreBase with _$PlacesStore;

abstract class PlacesStoreBase with Store {
  final PlaceRepository _placeRepository;
  final List<Place> _favorites = [];

  @observable
  ObservableFuture<List<Place>>? placesFuture;

  @observable
  ObservableFuture<List<Place>>? favoritesFuture;

  PlacesStoreBase(this._placeRepository);

  @action
  void getPlaces(Filter filter) {
    placesFuture = ObservableFuture(_sortedPlaces(filter));
  }

  @action
  void getFavorites() {
    // Вероятно в будущем данные о местах к посещению будем хранить в памяти устройства
    // и читать при необходимости. Пока это не рализовано, будем хранить список мест в поле объекта.
    // Для имитации асинхронного чтения обернем список во Future
    favoritesFuture = ObservableFuture(Future.value(_favorites));
  }

  @action
  void addToFavorites(Place place) {
    _favorites.add(place);
    getFavorites();
  }

  @action
  void removeFromFavorites(Place place) {
    _favorites.removeWhere((element) => element.id == place.id);
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