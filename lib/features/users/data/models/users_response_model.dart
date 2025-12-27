import 'user_model.dart';

class UsersResponseModel {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> users;

  const UsersResponseModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      page: json['page'] as int,
      perPage: json['per_page'] as int,
      total: json['total'] as int,
      totalPages: json['total_pages'] as int,
      users: (json['data'] as List)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
