import '../error/failures.dart';

class Result<T> {
  final T? data;
  final Failure? failure;

  const Result._({this.data, this.failure});

  factory Result.success(T data) => Result._(data: data);
  factory Result.failure(Failure failure) => Result._(failure: failure);

  bool get isSuccess => data != null && failure == null;

  bool get isFailure => failure != null;

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess(data as T);
    } else {
      return onFailure(failure!);
    }
  }

  T getOrThrow() {
    if (isSuccess) {
      return data as T;
    } else {
      throw failure!;
    }
  }

  T getOrElse(T defaultValue) {
    return data ?? defaultValue;
  }
}
