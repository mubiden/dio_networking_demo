import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final bool isLoading;
  final String message;

  const StatusCard({super.key, required this.isLoading, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isLoading ? Colors.blue.shade50 : Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isLoading ? Icons.refresh : Icons.check_circle,
                  color: isLoading ? Colors.blue : Colors.grey,
                ),
                const SizedBox(width: 8.0),
                Text(
                  isLoading ? 'Loading...' : 'Status',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(message, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
