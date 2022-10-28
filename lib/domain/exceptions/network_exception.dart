import 'package:places/ui/screen/res/strings.dart';

class NetworkException implements Exception {
  final String request;
  final int? code;
  final String? description;

  NetworkException(
      {required this.request, this.code, this.description,});

  @override
  String toString() {
    return "${AppStrings.inRequest}'$request' ${AppStrings.errorOccurred}: $code $description";
  }
}
