import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class FavouritePlacesState extends Equatable {
  const FavouritePlacesState();
}

class FavouritePlacesLoadState extends FavouritePlacesState {

  @override
  List<Object?> get props => [];

  const FavouritePlacesLoadState();
}

class FavouritePlacesErrorState extends FavouritePlacesState {
  final Object? err;

  @override
  List<Object?> get props => [err];

  const FavouritePlacesErrorState({required this.err});
}

class FavouritePlacesSuccessState extends FavouritePlacesState {
  final List<Place> favouritePlaces;

  @override
  List<Object?> get props => [favouritePlaces];

  const FavouritePlacesSuccessState({required this.favouritePlaces});
}
