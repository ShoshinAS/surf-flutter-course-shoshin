import 'package:places/data/mapper/place_type_mapper.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/location.dart';

extension PlaceMapper on Place {

  static Place fromApi(Map<String, dynamic> data) => Place(
      id: data['id'].toString(),
      name: data['name'] as String,
      location: Location(data['lat'] as double, data['lng'] as double),
      urls: (data['urls'] as List).cast<String>(),
      description: data['description'] as String,
      placeType: PlaceTypeMapper.fromApi(data['placeType'] as String),
  );

  Map<String, dynamic> toApi() {
    return <String, dynamic>{
      'name': name,
      'lat': location.latitude,
      'lng': location.longitude,
      'urls': urls,
      'description': description,
      'placeType': placeType.toApi(),
    };
  }

}
