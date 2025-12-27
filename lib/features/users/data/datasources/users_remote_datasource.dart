import '../models/user_model.dart';
import '../models/users_response_model.dart';

abstract class UsersRemoteDatasource {
  Future<UsersResponseModel> fetchUsers({int page = 1});
  Future<UserModel> fetchUser(int id);
}
