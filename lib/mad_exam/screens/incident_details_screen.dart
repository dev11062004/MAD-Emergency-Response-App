import 'package:flutter/material.dart';
import '../models/incident.dart';
import '../utils/helpers.dart';
import '../widgets/priority_badge.dart';

class IncidentDetailsScreen extends StatelessWidget {
  final Incident incident;

  const IncidentDetailsScreen({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    incident.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                PriorityBadge(priority: incident.priority),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.category, 'Category', incident.category),
            _buildInfoRow(Icons.info, 'Status', incident.status, color: Helpers.getStatusColor(incident.status)),
            _buildInfoRow(Icons.access_time, 'Reported At', Helpers.formatDate(incident.reportedTime)),
            _buildInfoRow(Icons.location_on, 'Location', incident.location),
            if (incident.assignedResponder != null && incident.assignedResponder!.isNotEmpty)
              _buildInfoRow(Icons.person, 'Responder', incident.assignedResponder!),
            if (!incident.isSynced)
              _buildInfoRow(Icons.cloud_off, 'Sync Status', 'Pending Sync', color: Colors.orange),
            
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                incident.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color ?? Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w500, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
