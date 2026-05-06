import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/incident_provider.dart';
import '../utils/helpers.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IncidentProvider>(
      builder: (context, provider, child) {
        final dist = provider.priorityDistribution;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Total\nIncidents', provider.totalIncidents.toString(), Colors.blue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Active\nIncidents', provider.activeIncidents.toString(), Colors.orange),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Resolved\nIncidents', provider.resolvedIncidents.toString(), Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Priority Distribution',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              if (provider.totalIncidents > 0)
                SizedBox(
                  height: 250,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: [
                        _buildPieChartSectionData('Critical', dist['Critical'] ?? 0, provider.totalIncidents),
                        _buildPieChartSectionData('High', dist['High'] ?? 0, provider.totalIncidents),
                        _buildPieChartSectionData('Medium', dist['Medium'] ?? 0, provider.totalIncidents),
                        _buildPieChartSectionData('Low', dist['Low'] ?? 0, provider.totalIncidents),
                      ],
                    ),
                  ),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text('No incidents reported yet.'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  PieChartSectionData _buildPieChartSectionData(String priority, int count, int total) {
    final double percentage = total == 0 ? 0 : (count / total) * 100;
    return PieChartSectionData(
      color: Helpers.getPriorityColor(priority),
      value: count.toDouble(),
      title: '${percentage.toStringAsFixed(0)}%',
      radius: 60,
      titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      badgeWidget: _Badge(priority, Helpers.getPriorityColor(priority)),
      badgePositionPercentageOffset: 1.3,
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
