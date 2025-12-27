import 'package:flutter/material.dart';

import 'core/network/dio_client.dart';
import 'core/storage/auth_token_manager.dart';
import 'features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenManager = AuthTokenManager();
    final dioClient = DioClient(
      baseUrl: 'https://reqres.in/api',
      tokenManager: tokenManager,
    );

    final authRemoteDataSource = AuthRemoteDataSourceImpl(dio: dioClient.dio);

    final authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
      tokenManager: tokenManager,
    );

    return MaterialApp(
      title: 'UpScrolled',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: HomeScreen(authRepository: authRepository),
    );
  }
}
