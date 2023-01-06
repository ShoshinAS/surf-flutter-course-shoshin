import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/visited_places/visited_places_event.dart';
import 'package:places/blocs/visited_places/visited_places_state.dart';
import 'package:places/data/repository/user_data_repository.dart';

class VisitedPlacesBloc extends Bloc<VisitedPlacesEvent, VisitedPlacesState> {
  final UserDataRepository userDataRepository;

  VisitedPlacesBloc({required this.userDataRepository})
      : super(const VisitedPlacesLoadState()) {
    on<VisitedPlacesLoadEvent>(_visitedPlacesLoadHandler);
    on<VisitedPlacesAddToVisitedEvent>(
      _visitedPlacesAddToVisitedLoadHandler,
    );
    on<VisitedPlacesRemoveFromVisitedEvent>(
      _visitedPlacesRemoveFromVisitedHandler,
    );
  }

  Future<void> _visitedPlacesLoadHandler(
    VisitedPlacesLoadEvent e,
    Emitter emit,
  ) async {
    try {
      final visitedPlaces = await userDataRepository.getVisitedPlaces();
      emit(VisitedPlacesSuccessState(visitedPlaces: visitedPlaces));
    } on Exception catch (err) {
      emit(VisitedPlacesErrorState(err: err));
    }
  }

  Future<void> _visitedPlacesAddToVisitedLoadHandler(
    VisitedPlacesAddToVisitedEvent e,
    Emitter emit,
  ) async {
    try {
      await userDataRepository.addToFavorites(e.place);
      final visitedPlaces = await userDataRepository.getVisitedPlaces();
      emit(VisitedPlacesSuccessState(visitedPlaces: visitedPlaces));
    } on Exception catch (err) {
      emit(VisitedPlacesErrorState(err: err));
    }
  }

  Future<void> _visitedPlacesRemoveFromVisitedHandler(
    VisitedPlacesRemoveFromVisitedEvent e,
    Emitter emit,
  ) async {
    try {
      await userDataRepository.removeFromFavorites(e.place);
      final visitedPlaces = await userDataRepository.getVisitedPlaces();
      emit(VisitedPlacesSuccessState(visitedPlaces: visitedPlaces));
    } on Exception catch (err) {
      emit(VisitedPlacesErrorState(err: err));
    }
  }
}
