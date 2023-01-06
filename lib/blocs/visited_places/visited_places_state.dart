import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class VisitedPlacesState extends Equatable {
  const VisitedPlacesState();
}

class VisitedPlacesLoadState extends VisitedPlacesState {

  @override
  List<Object?> get props => [];

  const VisitedPlacesLoadState();
}

class VisitedPlacesErrorState extends VisitedPlacesState {
  final Object? err;

  @override
  List<Object?> get props => [err];

  const VisitedPlacesErrorState({required this.err});
}

class VisitedPlacesSuccessState extends VisitedPlacesState {
  final List<Place> visitedPlaces;

  @override
  List<Object?> get props => [visitedPlaces];

  const VisitedPlacesSuccessState({required this.visitedPlaces});
}
