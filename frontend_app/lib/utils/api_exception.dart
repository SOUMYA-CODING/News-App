import 'package:dio/dio.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String? message;

  ApiException({this.statusCode, this.message});

  factory ApiException.fromResponse(Response response) {
    return ApiException(
      statusCode: response.statusCode,
      message: response.statusMessage,
    );
  }

  factory ApiException.fromError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return ApiException.fromResponse(error.response!);
      } else {
        return ApiException(message: 'Network error');
      }
    }
    return ApiException(message: 'Unknown error');
  }

  @override
  String toString() {
    return 'ApiException - Status Code: $statusCode, Message: $message';
  }
}
