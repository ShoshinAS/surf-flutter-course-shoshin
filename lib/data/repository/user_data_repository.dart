import 'package:places/data/model/place.dart';

// Репозиторий для получения сохраняемых данных пользователя
// (например любимых мест, мест запланированных к посещению)
// Пока все данные храним в классе и имитируем их чтение в асинхронном режиме
// В будущем данные судя по всему будут храниться на устройстве
class UserDataRepository {
  final List<Place> _favoritesPlaces = [];
  final List<Place> _visitedPlaces = [];

  UserDataRepository();

  Future<List<Place>> getFavoritesPlaces() async {
    return Future.value(List.from(_favoritesPlaces));
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

  Future<List<Place>> getVisitedPlaces() async {
    return Future.value(List.from(_visitedPlaces));
  }

  Future<void> addToVisitedPlaces(Place place) async {
    _visitedPlaces.add(place);
  }


}
