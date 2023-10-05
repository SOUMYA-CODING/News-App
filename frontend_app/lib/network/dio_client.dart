import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_app/constants/api_constants.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    BaseOptions options = BaseOptions(
      baseUrl: ENApi.apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    dio = Dio(options);

    // Debug mode only
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor());
    }
  }

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

  Future<Response<T>> post<T>(String path,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }
}
