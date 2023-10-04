import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_app/constants/api_constants.dart';
import 'package:frontend_app/utils/api_exception.dart';

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

  Future<T> _handleRequest<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      if (response.statusCode == 200) {
        return response.data!;
      } else {
        throw ApiException.fromResponse(response);
      }
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    return _handleRequest(() => dio.get<T>(
          path,
          queryParameters: queryParameters,
        ));
  }

  Future<T> post<T>(String path,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    return _handleRequest(() => dio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
        ));
  }
}
