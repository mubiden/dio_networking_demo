import 'dart:async';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration initialDelay;

  RetryInterceptor(
    this.dio, {
    this.maxRetries = 3,
    this.initialDelay = const Duration(milliseconds: 300),
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final attempt = requestOptions.extra['retry_count'] as int? ?? 0;

    if (!_shouldRetry(err) || attempt >= maxRetries) {
      return handler.next(err);
    }

    requestOptions.extra['retry_count'] = attempt + 1;
    await _retryWithDelay(attempt + 1);

    try {
      final response = await dio.fetch(requestOptions);
      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }

  Future<void> _retryWithDelay(int attempt) async {
    await Future.delayed(
      Duration(milliseconds: initialDelay.inMilliseconds * attempt),
    );
  }

  bool _shouldRetry(DioException err) {
    if (err.requestOptions.method != 'GET') return false;

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return true;
    }

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      return true;
    }

    final statusCode = err.response?.statusCode;
    return statusCode != null && statusCode >= 500;
  }
}
