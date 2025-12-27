import 'package:dio/dio.dart';

import '../../../../core/error/error_mapper.dart';
import '../models/auth_response_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthResponseModel> login({
    required String email,
    String? password,
  }) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
