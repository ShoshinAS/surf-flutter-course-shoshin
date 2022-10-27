import 'dart:math';
import 'package:places/data/model/location.dart';

// Строковые константы приложения
class MockStrings {
  static const openingHours = 'закрыто до 09:00';
  static const scheduledDate = 'Запланировано на 12 окт. 2020';
  static const visitDate = 'Цель достигнута 12 окт. 2020';
}

// координаты для тестирования радиуса поиска
class MockLocations {
  static Location location1 = Location(53.231653, 50.291682);
  static Location location2 = Location(53.208479, 50.124556);
  static Location location3 = Location(55.742251, 37.620522);
}

// изображения для добавления нового интересного места
class MockImages {
  static const _imageURLs = [
    'https://s09.stc.yc.kpcdn.net/share/i/12/7403181/wr-960.webp',
    'https://s09.stc.yc.kpcdn.net/share/i/12/7402956/wr-750.webp',
    'https://s14.stc.yc.kpcdn.net/share/i/12/7402970/wr-750.webp',
    'https://s13.stc.yc.kpcdn.net/share/i/12/7402996/wr-750.webp',
    'https://s13.stc.yc.kpcdn.net/share/i/12/7403001/wr-750.webp',
    'https://s13.stc.yc.kpcdn.net/share/i/12/7403007/wr-750.webp',
    'https://s09.stc.yc.kpcdn.net/share/i/12/7403060/wr-750.webp',
    'https://s15.stc.yc.kpcdn.net/share/i/12/7403494/wr-750.webp',
    'https://s12.stc.yc.kpcdn.net/share/i/12/7403479/wr-750.webp',
    'https://s09.stc.yc.kpcdn.net/share/i/12/7403362/wr-750.webp',
  ];
  static String randomURL() {
    return _imageURLs[Random().nextInt(_imageURLs.length)];
  }
}
