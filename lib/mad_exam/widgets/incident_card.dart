import 'package:flutter/material.dart';
import '../models/incident.dart';
import '../utils/helpers.dart';
import 'priority_badge.dart';

class IncidentCard extends StatelessWidget {
  final Incident incident;
  final VoidCallback onTap;

  const IncidentCard({super.key, required this.incident, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isCritical = incident.priority == 'Critical';
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isCritical ? const BorderSide(color: Colors.red, width: 1.5) : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (isCritical)
                          const Icon(Icons.warning, color: Colors.red, size: 20),
                        if (isCritical) const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            incident.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PriorityBadge(priority: incident.priority),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.category, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(incident.category, style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(width: 16),
                  Icon(Icons.circle, size: 12, color: Helpers.getStatusColor(incident.status)),
                  const SizedBox(width: 4),
                  Text(incident.status, style: TextStyle(color: Colors.grey[700])),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Helpers.formatDate(incident.reportedTime),
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  if (!incident.isSynced)
                    const Icon(Icons.cloud_off, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
