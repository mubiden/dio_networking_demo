import 'package:flutter/material.dart';

import '../../auth/data/repositories/auth_repository_impl.dart';
import '../../auth/presentation/widgets/auth_section.dart';
import '../../users/data/models/user_model.dart';
import '../../users/presentation/widgets/users_section.dart';
import 'widgets/status_card.dart';

class HomeScreen extends StatefulWidget {
  final AuthRepositoryImpl authRepository;
  const HomeScreen({super.key, required this.authRepository});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String _statusMessage = 'Ready';
  List<UserModel> _users = [];

  Future<void> _handleLoginSuccess() async {
    _setLoading(true, 'Logging in...', []);

    final result = await widget.authRepository.login(
      email: 'eve.holt@reqres.in',
      password: 'cityslicka',
    );

    result.fold(
      onSuccess: (response) {
        _setLoading(false, '✅ Login successful! Token: ${response.token}', []);
      },
      onFailure: (failure) {
        _setLoading(false, '❌ Login failed: ${failure.message}', []);
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
        setState(() {
          _isLoading = false;
          _statusMessage = '✅ Unexpected success';
        });
      },
      onFailure: (failure) {
        setState(() {
          _isLoading = false;
          _statusMessage =
              '❌ Expected failure: ${failure.message} (${failure.statusCode})';
        });
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
              setState(() {
                _users = [];
                _statusMessage = '🔒 Logged out. Token cleared.';
              });
              Navigator.pop(context);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleFetchUsers() async {
    _setLoading(true, 'Fetching users...', []);
  }

  void _setLoading(bool loading, String message, List<UserModel> users) {
    setState(() {
      _isLoading = loading;
      _statusMessage = message;
      _users = users;
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
