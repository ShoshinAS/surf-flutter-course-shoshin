import 'package:places/data/mapper/place_type_mapper.dart';
import 'package:places/data/model/filter.dart';

extension FilterMapper on Filter {
  Map<String, dynamic> toApi() {
    return <String, dynamic>{
      'lat': location.latitude,
      'lng': location.longitude,
      'radius': radius,
      if (typeFilter.isNotEmpty)
        'typeFilter': typeFilter.map((e) => e.toApi()).toList(),
      if (nameFilter.isNotEmpty) 'nameFilter': nameFilter,
    };
  }
}
