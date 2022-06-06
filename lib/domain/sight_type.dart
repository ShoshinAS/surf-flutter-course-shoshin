import 'package:places/ui/screen/res/strings.dart';

enum SightType {
  hotel,
  restaurant,
  particular,
  park,
  museum,
  cafe;

  @override
  String toString() {
    switch(this){
      case hotel:
        return AppStrings.typeHotel;
      case restaurant:
        return AppStrings.typeRestaurant;
      case particular:
        return AppStrings.typeSpecial;
      case park:
        return AppStrings.typePark;
      case museum:
        return AppStrings.typeMuseum;
      case cafe:
        return AppStrings.typeCafe;
      default:
        return '';
    }
  }

}