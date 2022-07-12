import 'package:flutter/material.dart';

// класс реализует историю поиска и операции с ней
class SearchHistory extends ChangeNotifier{
  final List<String> _history;

  bool get isEmpty => _history.isEmpty;

  SearchHistory() : _history = [];

  void add(String query) {
    if (query.isNotEmpty) {
      _history
        ..remove(query)
        ..insert(0, query);
      notifyListeners();
    }
  }

  void remove(String query) {
    _history.remove(query);
    notifyListeners();
  }

  void clear(){
    _history.clear();
  }

  List<String> toList() {
    return _history;
  }

}