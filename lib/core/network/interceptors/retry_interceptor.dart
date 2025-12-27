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

    final shouldRetry = _shouldRetry(err) && attempt < maxRetries;

    if (shouldRetry) {
      requestOptions.extra['retry_count'] = attempt + 1;

      final delayMs = initialDelay.inMilliseconds * (attempt + 1);
      await Future.delayed(Duration(milliseconds: delayMs));

      try {
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    // Only retry GET (idempotent)
    if (err.requestOptions.method != 'GET') return false;

    // Retry on timeout
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return true;
    }

    // Retry on network/socket errors
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      return true;
    }

    // Retry on 5xx server errors
    final statusCode = err.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      return true;
    }

    return false;
  }
}
