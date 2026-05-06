import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/incident_provider.dart';
import '../widgets/incident_card.dart';
import 'incident_details_screen.dart';

class IncidentListScreen extends StatelessWidget {
  const IncidentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IncidentProvider>(
      builder: (context, provider, child) {
        if (provider.incidents.isEmpty) {
          return const Center(
            child: Text('No incidents reported.'),
          );
        }

        return ListView.builder(
          itemCount: provider.incidents.length,
          itemBuilder: (context, index) {
            final incident = provider.incidents[index];
            return IncidentCard(
              incident: incident,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncidentDetailsScreen(incident: incident),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
