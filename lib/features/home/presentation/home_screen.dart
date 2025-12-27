import 'package:flutter/material.dart';

import '../../auth/data/repositories/auth_repository_impl.dart';
import '../../auth/presentation/widgets/auth_section.dart';
import '../../users/data/models/user_model.dart';
import '../../users/data/repositories/users_repository_impl.dart';
import '../../users/presentation/widgets/users_section.dart';
import 'widgets/status_card.dart';

class HomeScreen extends StatefulWidget {
  final AuthRepositoryImpl authRepository;
  final UsersRepositoryImpl usersRepository;

  const HomeScreen({
    super.key,
    required this.authRepository,
    required this.usersRepository,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String _statusMessage = 'Ready';

  Future<void> _handleLoginSuccess() async {
    _setLoading(true, 'Logging in...');

    final result = await widget.authRepository.login(
      email: 'eve.holt@reqres.in',
      password: 'cityslicka',
    );

    result.fold(
      onSuccess: (response) {
        _setLoading(false, '✅ Login successful! Token: ${response.token}');
      },
      onFailure: (failure) {
        _setLoading(false, '❌ Login failed: ${failure.message}');
      },
    );
  }

  Future<void> _handleLoginFailure() async {
    setState(() {
      _isLoading = false;
      _statusMessage = 'Attempting login without password...';
    });

    final result = await widget.authRepository.login(
      email: 'eve.holt@reqres.in',
      password: '',
    );

    result.fold(
      onSuccess: (response) {
        _setLoading(false, '✅ Unexpected success');
      },
      onFailure: (failure) {
        _setLoading(
          false,
          '❌ Expected failure: ${failure.message} (${failure.statusCode})',
        );
      },
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.authRepository.logout();
              _setLoading(false, '🔒 Logged out. Token cleared.');
              Navigator.pop(context);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleFetchUsers() async {
    _setLoading(true, 'Fetching users...');
    final result = await widget.usersRepository.fetchUsers();
    final users = (result as List)
        .map((json) => UserModel.fromJson(json))
        .toList();

    result.fold(
      onSuccess: (response) {
        _setLoading(
          false,
          '✅ Fetched ${users.length} users (Page ${response.page}/${response.totalPages})',
        );
      },
      onFailure: (failure) {
        _setLoading(
          false,
          '❌ Fetch failed: ${failure.message} (${failure.statusCode ?? 'N/A'})',
        );
      },
    );
  }

  void _setLoading(bool loading, String message) {
    setState(() {
      _isLoading = loading;
      _statusMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UpScrolled')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StatusCard(isLoading: _isLoading, message: _statusMessage),
            const SizedBox(height: 16),
            AuthSection(
              onLoginSuccess: _handleLoginSuccess,
              onLoginFailure: _handleLoginFailure,
              onLogout: _handleLogout,
            ),
            const SizedBox(height: 16),
            UsersSection(onFetchUsers: _handleFetchUsers, onFetchUser: () {}),
          ],
        ),
      ),
    );
  }
}
