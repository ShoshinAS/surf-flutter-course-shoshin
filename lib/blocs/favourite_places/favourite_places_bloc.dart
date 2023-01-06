import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favourite_places/favourite_places_event.dart';
import 'package:places/blocs/favourite_places/favourite_places_state.dart';
import 'package:places/data/repository/user_data_repository.dart';

class FavouritePlacesBloc
    extends Bloc<FavouritePlacesEvent, FavouritePlacesState> {
  final UserDataRepository userDataRepository;

  FavouritePlacesBloc({required this.userDataRepository})
      : super(const FavouritePlacesLoadState()) {
    on<FavouritePlacesLoadEvent>(_favouritePlacesLoadHandler);
    on<FavouritePlacesAddToFavouritesEvent>(
      _favouritePlacesAddToFavouritesLoadHandler,
    );
    on<FavouritePlacesRemoveFromFavouritesEvent>(
      _favouritePlacesRemoveFromFavouritesHandler,
    );
    on<FavouritePlacesMoveOnFavouritesEvent>(
      _favouritePlacesMoveOnFavouritesHandler,
    );
  }

  Future<void> _favouritePlacesLoadHandler(
    FavouritePlacesLoadEvent e,
    Emitter emit,
  ) async {
    try {
      final favouritePlaces = await userDataRepository.getFavoritesPlaces();
      emit(FavouritePlacesSuccessState(favouritePlaces: favouritePlaces));
    } on Exception catch (err) {
      emit(FavouritePlacesErrorState(err: err));
    }
  }

  Future<void> _favouritePlacesAddToFavouritesLoadHandler(
    FavouritePlacesAddToFavouritesEvent e,
    Emitter emit,
  ) async {
    try {
      await userDataRepository.addToFavorites(e.place);
      final favouritePlaces = await userDataRepository.getFavoritesPlaces();
      emit(FavouritePlacesSuccessState(favouritePlaces: favouritePlaces));
    } on Exception catch (err) {
      emit(FavouritePlacesErrorState(err: err));
    }
  }

  Future<void> _favouritePlacesRemoveFromFavouritesHandler(
    FavouritePlacesRemoveFromFavouritesEvent e,
    Emitter emit,
  ) async {
    try {
      await userDataRepository.removeFromFavorites(e.place);
      final favouritePlaces = await userDataRepository.getFavoritesPlaces();
      emit(FavouritePlacesSuccessState(favouritePlaces: favouritePlaces));
    } on Exception catch (err) {
      emit(FavouritePlacesErrorState(err: err));
    }
  }

  Future<void> _favouritePlacesMoveOnFavouritesHandler(
    FavouritePlacesMoveOnFavouritesEvent e,
    Emitter emit,
  ) async {
    try {
      await userDataRepository.moveOnFavorites(e.sourcePlace, e.targetPlace);
      final favouritePlaces = await userDataRepository.getFavoritesPlaces();
      emit(FavouritePlacesSuccessState(favouritePlaces: favouritePlaces));
    } on Exception catch (err) {
      emit(FavouritePlacesErrorState(err: err));
    }
  }
}
