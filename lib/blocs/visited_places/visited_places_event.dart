import 'package:equatable/equatable.dart';
import 'package:places/data/model/place.dart';

abstract class VisitedPlacesEvent extends Equatable {
  const VisitedPlacesEvent();
}

class VisitedPlacesLoadEvent extends VisitedPlacesEvent {
  @override
  List<Object?> get props => [];

  const VisitedPlacesLoadEvent();
}

class VisitedPlacesAddToVisitedEvent extends VisitedPlacesEvent {
  final Place place;

  @override
  List<Object?> get props => [];

  const VisitedPlacesAddToVisitedEvent({required this.place});
}

class VisitedPlacesRemoveFromVisitedEvent extends VisitedPlacesEvent {
  final Place place;

  @override
  List<Object?> get props => [];

  const VisitedPlacesRemoveFromVisitedEvent({required this.place});
}

