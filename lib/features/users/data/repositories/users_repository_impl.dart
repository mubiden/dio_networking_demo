import 'package:dio/dio.dart';

import '../../../../core/error/error_mapper.dart';
import '../../../../core/network/result.dart';
import '../datasources/users_remote_datasource.dart';
import '../models/user_model.dart';
import '../models/users_response_model.dart';

class UsersRepositoryImpl {
  final UsersRemoteDatasource remoteDatasource;

  UsersRepositoryImpl({required this.remoteDatasource});

  Future<Result<UsersResponseModel>> fetchUsers({int page = 1}) async {
    try {
      final response = await remoteDatasource.fetchUsers(page: page);
      return Result.success(response);
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }

  Future<Result<UserModel>> fetchUser(int id) async {
    try {
      final user = await remoteDatasource.fetchUser(id);
      return Result.success(user);
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
