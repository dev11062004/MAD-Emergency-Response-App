import 'package:flutter/material.dart';
import '../utils/helpers.dart';

class PriorityBadge extends StatelessWidget {
  final String priority;
  
  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Helpers.getPriorityColor(priority).withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Helpers.getPriorityColor(priority)),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          color: Helpers.getPriorityColor(priority),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
