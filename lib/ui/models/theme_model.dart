import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';

// класс реализует переключение темы
class ThemeModel extends ChangeNotifier{
  final SettingsInteractor _searchInteractor;

  bool get isDarkTheme => _isDarkTheme;

  bool _isDarkTheme = false;

  ThemeModel() : _searchInteractor = SettingsInteractor();

  Future<void> setTheme({required bool isDarkTheme}) async {
    await _searchInteractor.setTheme(isDarkTheme: isDarkTheme);
    await updateTheme();
  }

  Future<void> updateTheme() async {
    _isDarkTheme = await _searchInteractor.getTheme();
    notifyListeners();
  }

}