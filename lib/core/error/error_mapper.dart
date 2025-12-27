import 'package:dio/dio.dart';

import 'failures.dart';

Failure mapDioError(DioException e) {
  final domainError =
      e.requestOptions.extra['domainError'] as Map<String, dynamic>?;

  if (domainError != null) {
    final type = domainError['type'] as String;
    final message = domainError['message'] as String?;
    final code = domainError['code'] as int?;

    switch (type) {
      case 'BadRequest':
        return BadRequestFailure(message: message);
      case 'Unauthorized':
        return UnauthorizedFailure(message: message);
      case 'NotFound':
        return NotFoundFailure(message: message);
      case 'Server':
        return ServerFailure(message: message, statusCode: code);
      case 'Timeout':
        return const TimeoutFailure();
      case 'Network':
        return const NetworkFailure();
      default:
        return UnknownFailure(message: message);
    }
  }

  final statusCode = e.response?.statusCode;

  if (statusCode != null) {
    switch (statusCode) {
      case 400:
        return const BadRequestFailure();
      case 401:
        return const UnauthorizedFailure();
      case 404:
        return const NotFoundFailure();
      case >= 500:
        return ServerFailure(statusCode: statusCode);
    }
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return const TimeoutFailure();
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      return const NetworkFailure();
    default:
      return UnknownFailure(message: e.message);
  }
}
