import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class FavouritePlacesEvent extends Equatable {
  const FavouritePlacesEvent();
}

class FavouritePlacesLoadEvent extends FavouritePlacesEvent {
  @override
  List<Object?> get props => [];

  const FavouritePlacesLoadEvent();
}

class FavouritePlacesAddToFavouritesEvent extends FavouritePlacesEvent {
  final Place place;

  @override
  List<Object?> get props => [place];

  const FavouritePlacesAddToFavouritesEvent({required this.place});
}

class FavouritePlacesRemoveFromFavouritesEvent extends FavouritePlacesEvent {
  final Place place;

  @override
  List<Object?> get props => [place];

  const FavouritePlacesRemoveFromFavouritesEvent({required this.place});
}

class FavouritePlacesMoveOnFavouritesEvent extends FavouritePlacesEvent {
  final Place sourcePlace;
  final Place? targetPlace;

  @override
  List<Object?> get props => [sourcePlace, targetPlace];

  const FavouritePlacesMoveOnFavouritesEvent({
    required this.sourcePlace,
    required this.targetPlace,
  });
}
