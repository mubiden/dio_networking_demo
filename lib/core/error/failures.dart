sealed class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({String? message})
    : super(message: message ?? 'Invalid request', statusCode: 400);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String? message})
    : super(
        message: message ?? 'Unauthorized. Please login again.',
        statusCode: 401,
      );
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String? message})
    : super(message: message ?? 'Resource not found', statusCode: 404);
}

class ServerFailure extends Failure {
  const ServerFailure({String? message, int? statusCode})
    : super(
        message: message ?? 'Server error. Please try again later.',
        statusCode: statusCode,
      );
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? message})
    : super(
        message:
            message ?? 'No internet connection. Please check your network.',
        statusCode: null,
      );
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({String? message})
    : super(
        message: message ?? 'Request timeout. Please try again.',
        statusCode: null,
      );
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? message})
    : super(
        message: message ?? 'An unexpected error occurred',
        statusCode: null,
      );
}
