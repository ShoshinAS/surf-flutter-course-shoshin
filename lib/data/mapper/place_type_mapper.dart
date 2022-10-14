import 'package:places/data/model/place_type.dart';

extension PlaceTypeMapper on PlaceType {

  static PlaceType fromApi(String data) {
    switch(data){
      case 'hotel':
        return PlaceType.hotel;
      case 'restaurant':
        return PlaceType.restaurant;
      case 'park':
        return PlaceType.park;
      case 'museum':
        return PlaceType.museum;
      case 'cafe':
        return PlaceType.cafe;
      default:
        return PlaceType.particular;
    }
  }

  String toApi() {
    switch(this){
      case PlaceType.hotel:
        return 'hotel';
      case PlaceType.restaurant:
        return 'restaurant';
      case PlaceType.particular:
        return 'other';
      case PlaceType.park:
        return 'park';
      case PlaceType.museum:
        return 'museum';
      case PlaceType.cafe:
        return 'cafe';
      default:
        return '';
    }
  }

}
