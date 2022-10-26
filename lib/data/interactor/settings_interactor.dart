class SettingsInteractor {
  bool _isDarkTheme;

  SettingsInteractor() : _isDarkTheme = false;

  Future<void> setTheme({required bool isDarkTheme}) async {
    _isDarkTheme = isDarkTheme;
  }

  Future<bool> getTheme() {
    return Future.value(_isDarkTheme);
  }

}