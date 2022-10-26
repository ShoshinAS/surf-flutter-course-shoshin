import 'package:flutter/material.dart';
import 'package:places/data/api/api.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

class FavoriteModel extends ChangeNotifier {
  final PlaceInteractor _placeInteractor;

  FavoriteModel() : _placeInteractor = PlaceInteractor(PlaceRepository(Api.dio()));

  Future<void> add(Place place) async {
    await _placeInteractor.addToFavorites(place);
    notifyListeners();
  }

  Future<void> remove(Place place) async {
    await _placeInteractor.removeFromFavorites(place);
    notifyListeners();
  }

  Future<void> move(Place sourcePlace, Place? targetPlace) async {
    await _placeInteractor.moveOnFavorites(sourcePlace, targetPlace);
    notifyListeners();
  }

  Future<List<Place>> get() async {
    return _placeInteractor.getFavoritesPlaces();
  }

}
