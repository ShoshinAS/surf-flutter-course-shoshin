import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier{

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }

  bool _darkTheme = false;

}