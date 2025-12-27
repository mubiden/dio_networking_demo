import 'package:flutter/material.dart';

class AuthSection extends StatelessWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onLoginFailure;
  final VoidCallback onLogout;

  const AuthSection({
    super.key,
    required this.onLoginSuccess,
    required this.onLoginFailure,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Authentication',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _AuthButton(
              label: 'Login (Success)',
              color: Colors.green,
              onPressed: onLoginSuccess,
            ),
            const SizedBox(height: 8),
            _AuthButton(
              label: 'Login (Failure)',
              color: Colors.orange,
              onPressed: onLoginFailure,
            ),
            const SizedBox(height: 8),
            _AuthButton(
              label: 'Logout',
              color: Colors.red,
              onPressed: onLogout,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _AuthButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
