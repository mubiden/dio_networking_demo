import 'package:dio/dio.dart';

import '../../../../core/error/error_mapper.dart';
import '../models/user_model.dart';
import '../models/users_response_model.dart';
import 'users_remote_datasource.dart';

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  final Dio dio;

  UsersRemoteDatasourceImpl({required this.dio});

  @override
  Future<UsersResponseModel> fetchUsers({int page = 1}) async {
    try {
      final response = await dio.get('/users', queryParameters: {'page': page});
      return UsersResponseModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<UserModel> fetchUser(int id) async {
    try {
      final response = await dio.get('/users/$id');
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
