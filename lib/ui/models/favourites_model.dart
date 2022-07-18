import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';


abstract class Favourites extends ChangeNotifier {
  final List<Sight> _list;

  Favourites(this._list);

  void add(Sight sight){
    _list.add(sight);
    notifyListeners();
  }

  void remove(Sight sight){
    _list.remove(sight);
    notifyListeners();
  }

  void move(Sight sourceSight, Sight? targetSight) {
    _list.remove(sourceSight);
    if (targetSight != null) {
      _list.insert(_list.indexOf(targetSight), sourceSight);
    } else {
      _list.add(sourceSight);
    }
    notifyListeners();
  }

  List<Sight> toList(){
    return _list;
  }

}

class VisitedSights extends Favourites{
  VisitedSights(super.list);
}

class ScheduledSights extends Favourites{
  ScheduledSights(super.list);
}