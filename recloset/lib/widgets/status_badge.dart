// widgets/status_badge.dart
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Color _statusColor(String status) {
    switch (status) {
      case 'ACCEPTED':
        return const Color(0xff48A6A7);
      case 'REJECTED':
        return const Color(0xffF16767);
      default:
        return const Color(0xff2C2C2C);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
        color: _statusColor(status),
        borderRadius: BorderRadius.circular(10.5),
      ),
      child: Text(
        status.toLowerCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
