import 'package:dio/dio.dart';

import '../../core/storage/auth_token_manager.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class DioClient {
  final Dio _dio;
  final AuthTokenManager tokenManager;

  DioClient({required String baseUrl, required this.tokenManager})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'reqres-free-v1',
          },
        ),
      ) {
    _addInterceptors();
  }

  Dio get dio => _dio;

  void _addInterceptors() {
    _dio.interceptors.addAll([
      AuthInterceptor(tokenManager),
      RetryInterceptor(_dio),
    ]);
  }
}
