import 'package:flutter/foundation.dart';
import 'package:places/domain/sight.dart';

// класс реализует логику поиска по фрагментам наименования
// в списке интересных мест
class Search {
  final List<Sight> _result;
  final List<String> _words;
  final List<Sight> _sightList;

  List<Sight> get result => _result;
  List<String> get words => _words;
  SearchStatus? get status => _status;

  SearchStatus? _status;

  Search()
      : _sightList = [],
        _result = [],
        _words = [];

  void initialize(List<Sight> sightList) {
    _sightList..clear()
    ..addAll(sightList);
  }

  Future<void> find(
      String query,
      {required VoidCallback onFinish,}) async {
    _result.clear();
    _words.clear();
    _status = SearchStatus.inProgress;

    // задержка для имитации загрузки из сети
    await Future.delayed(const Duration(seconds: 1), () {});

    _words
      ..addAll(query.split(' '))
      ..removeWhere((element) => element.isEmpty);

    for (final sight in _sightList) {
      var found = true;
      for (final word in _words) {
        if (!sight.name.toLowerCase().contains(word.toLowerCase())) {
          found = false;
          break;
        }
      }
      if (found) {
        _result.add(sight);
      }
    }
    _status = SearchStatus.finished;
    onFinish();
  }
}

enum SearchStatus { inProgress, error, finished }
