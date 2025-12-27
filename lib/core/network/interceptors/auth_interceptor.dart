import 'package:dio/dio.dart';

import '../../storage/auth_token_manager.dart';

class AuthInterceptor extends Interceptor {
  final AuthTokenManager authTokenManager;

  AuthInterceptor(this.authTokenManager);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authTokenManager.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
