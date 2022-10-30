import 'package:flutter/widgets.dart';

class SettingsInteractor extends ChangeNotifier {
  bool _isDarkTheme;

  SettingsInteractor() : _isDarkTheme = false;

  Future<void> setTheme({required bool isDarkTheme}) async {
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }

  Future<bool> getTheme() {
    return Future.value(_isDarkTheme);
  }

}