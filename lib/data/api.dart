import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api_constants.dart';

class Api {

  static Dio dio() {
    final baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
    );
    final dio = Dio(baseOptions);
    dio.interceptors.add(_LogInterceptor());

    return dio;
  }

}

class _LogInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Request: ${options.baseUrl}, ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('Error: ${err.toString()}');
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response: ${response.toString()}');
    super.onResponse(response, handler);
  }
}