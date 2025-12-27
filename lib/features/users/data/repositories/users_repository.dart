import 'package:dio/dio.dart';

import '../../../../core/error/error_mapper.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/result.dart';
import '../models/user_model.dart';
import '../models/users_response_model.dart';

class UsersRepository {
  final DioClient dioClient;

  UsersRepository({required this.dioClient});

  Future<Result<UsersResponseModel>> fetchUsers({int page = 1}) async {
    try {
      final response = await dioClient.dio.get(
        '/users',
        queryParameters: {'page': page},
      );

      final usersResponse = UsersResponseModel.fromJson(response.data);
      return Result.success(usersResponse);
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }

  Future<Result<UserModel>> fetchUser(int id) async {
    try {
      final response = await dioClient.dio.get('/users/$id');
      final user = UserModel.fromJson(response.data['data']);
      return Result.success(user);
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
