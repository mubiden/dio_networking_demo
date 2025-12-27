import 'package:dio_networking_demo/core/error/failures.dart';

import '../../../../core/network/result.dart';
import '../../../../core/storage/auth_token_manager.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_response_model.dart';

class AuthRepositoryImpl {
  final AuthRemoteDataSource remoteDataSource;
  final AuthTokenManager tokenManager;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenManager,
  });

  Future<Result<AuthResponseModel>> login({
    required String email,
    String? password,
  }) async {
    try {
      final model = await remoteDataSource.login(
        email: email,
        password: password,
      );

      tokenManager.saveToken(model.token);
      return Result.success(model);
    } on Failure catch (e) {
      return Result.failure(e);
    }
  }

  void logout() {
    tokenManager.clearToken();
  }
}
