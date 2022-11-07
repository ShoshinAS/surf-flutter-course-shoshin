// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlacesStore on PlacesStoreBase, Store {
  late final _$placesFutureAtom =
      Atom(name: 'PlacesStoreBase.placesFuture', context: context);

  @override
  ObservableFuture<List<Place>>? get placesFuture {
    _$placesFutureAtom.reportRead();
    return super.placesFuture;
  }

  @override
  set placesFuture(ObservableFuture<List<Place>>? value) {
    _$placesFutureAtom.reportWrite(value, super.placesFuture, () {
      super.placesFuture = value;
    });
  }

  late final _$favoritesFutureAtom =
      Atom(name: 'PlacesStoreBase.favoritesFuture', context: context);

  @override
  ObservableFuture<List<Place>>? get favoritesFuture {
    _$favoritesFutureAtom.reportRead();
    return super.favoritesFuture;
  }

  @override
  set favoritesFuture(ObservableFuture<List<Place>>? value) {
    _$favoritesFutureAtom.reportWrite(value, super.favoritesFuture, () {
      super.favoritesFuture = value;
    });
  }

  late final _$PlacesStoreBaseActionController =
      ActionController(name: 'PlacesStoreBase', context: context);

  @override
  void getPlaces(Filter filter) {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.getPlaces');
    try {
      return super.getPlaces(filter);
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getFavorites() {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.getFavorites');
    try {
      return super.getFavorites();
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToFavorites(Place place) {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.addToFavorites');
    try {
      return super.addToFavorites(place);
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromFavorites(Place place) {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.removeFromFavorites');
    try {
      return super.removeFromFavorites(place);
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
placesFuture: ${placesFuture},
favoritesFuture: ${favoritesFuture}
    ''';
  }
}
