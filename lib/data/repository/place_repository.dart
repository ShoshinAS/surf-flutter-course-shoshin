import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:places/data/mapper/filter_mapper.dart';
import 'package:places/data/mapper/place_mapper.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/places_query_parameters.dart';
import 'package:places/domain/exceptions/network_exception.dart';

class PlaceRepository {
  final Dio dio;

  PlaceRepository(this.dio);

  Future<List<Place>> getFilteredPlaces(Filter filter) async {
    final response = await dio.post<String>(
      '/filtered_places',
      data: filter.toApi(),
    );
    if (response.statusCode != 200) {
      throw NetworkException(
        request: response.requestOptions.path,
        code: response.statusCode,
        description: response.statusMessage,
      );
    }
    final parsedData =
        (jsonDecode(response.data!) as List).cast<Map<String, dynamic>>();
    final result = parsedData.map(PlaceMapper.fromApi).toList();

    return result;
  }

  Future<Place> addPlace(Place place) async {
    final response = await dio.post<String>(
      '/place',
      data: place.toApi(),
    );
    if (response.statusCode != 200) {
      throw NetworkException(
        request: response.requestOptions.uri.toString(),
        code: response.statusCode,
        description: response.statusMessage,
      );
    }
    final parsedData = jsonDecode(response.data!) as Map<String, dynamic>;
    final result = PlaceMapper.fromApi(parsedData);

    return result;
  }

  Future<List<Place>> getPlaces(
    PlacesQueryParameters placesQueryParameters,
  ) async {
    final response = await dio.get<String>(
      '/place',
      queryParameters: placesQueryParameters.toMap(),
    );
    if (response.statusCode != 200) {
      throw NetworkException(
        request: response.requestOptions.uri.toString(),
        code: response.statusCode,
        description: response.statusMessage,
      );
    }
    final parsedData =
        (jsonDecode(response.data!) as List).cast<Map<String, dynamic>>();
    final result = parsedData.map(PlaceMapper.fromApi).toList();

    return result;
  }

  Future<Place> getPlace(String id) async {
    final response = await dio.get<String>(
      '/place/$id',
    );
    if (response.statusCode != 200) {
      throw NetworkException(
        request: response.requestOptions.uri.toString(),
        code: response.statusCode,
        description: response.statusMessage,
      );
    }
    final parsedData = jsonDecode(response.data!) as Map<String, dynamic>;
    final result = PlaceMapper.fromApi(parsedData);

    return result;
  }

  Future<void> deletePlace(String id) async {
    final response = await dio.delete<String>(
      '/place/$id',
    );
    if (response.statusCode != 200) {
      throw NetworkException(
        request: response.requestOptions.uri.toString(),
        code: response.statusCode,
        description: response.statusMessage,
      );
    }
  }

  Future<Place> updatePlace(String id, Place place) async {
    final response = await dio.put<String>(
      '/place/$id',
      data: place.toApi(),
    );
    if (response.statusCode != 200) {
      throw NetworkException(
        request: response.requestOptions.uri.toString(),
        code: response.statusCode,
        description: response.statusMessage,
      );
    }
    final parsedData = jsonDecode(response.data!) as Map<String, dynamic>;
    final result = PlaceMapper.fromApi(parsedData);

    return result;
  }
}
