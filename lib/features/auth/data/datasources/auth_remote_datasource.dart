import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({required String email, String? password});
}
