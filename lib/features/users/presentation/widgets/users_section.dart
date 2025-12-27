import 'package:flutter/material.dart';

class UsersSection extends StatelessWidget {
  final VoidCallback onFetchUsers;
  final VoidCallback onFetchUser;

  const UsersSection({
    super.key,
    required this.onFetchUsers,
    required this.onFetchUser,
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
              'Users Endpoints',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _UsersButton(
              label: 'Fetch Users',
              onPressed: onFetchUsers,
              color: Colors.blue,
            ),
            const SizedBox(height: 8),
            _UsersButton(
              label: 'Fetch User 999',
              onPressed: onFetchUser,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class _UsersButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _UsersButton({
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
