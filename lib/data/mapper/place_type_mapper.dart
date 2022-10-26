import 'package:places/data/model/place_type.dart';
import 'package:places/ui/screen/res/strings.dart';

extension PlaceTypeMapper on PlaceType {

  static PlaceType fromApi(String data) {
    switch(data){
      case AppStrings.typeHotelApi:
        return PlaceType.hotel;
      case AppStrings.typeRestaurantApi:
        return PlaceType.restaurant;
      case AppStrings.typeParkApi:
        return PlaceType.park;
      case AppStrings.typeMuseumApi:
        return PlaceType.museum;
      case AppStrings.typeCafeApi:
        return PlaceType.cafe;
      default:
        return PlaceType.particular;
    }
  }

  String toApi() {
    switch(this){
      case PlaceType.hotel:
        return AppStrings.typeHotelApi;
      case PlaceType.restaurant:
        return AppStrings.typeRestaurantApi;
      case PlaceType.particular:
        return AppStrings.typeOtherApi;
      case PlaceType.park:
        return AppStrings.typeParkApi;
      case PlaceType.museum:
        return AppStrings.typeMuseumApi;
      case PlaceType.cafe:
        return AppStrings.typeCafeApi;
      default:
        return AppStrings.typeOtherApi;
    }
  }

}
