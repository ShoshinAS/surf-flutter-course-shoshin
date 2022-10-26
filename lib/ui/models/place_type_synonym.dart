import 'package:places/data/model/place_type.dart';
import 'package:places/ui/screen/res/strings.dart';

extension PlaceTypeSynonym on PlaceType {

  String synonym() {
    switch(this){
      case PlaceType.hotel:
        return AppStrings.typeHotel;
      case PlaceType.restaurant:
        return AppStrings.typeRestaurant;
      case PlaceType.particular:
        return AppStrings.typeSpecial;
      case PlaceType.park:
        return AppStrings.typePark;
      case PlaceType.museum:
        return AppStrings.typeMuseum;
      case PlaceType.cafe:
        return AppStrings.typeCafe;
      default:
        return '';
    }
  }

}