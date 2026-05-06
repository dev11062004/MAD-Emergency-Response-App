import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/incident_provider.dart';
import '../constants/app_constants.dart';
import '../widgets/incident_card.dart';
import 'incident_details_screen.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  final _searchController = TextEditingController();
  String _selectedStatus = 'All';
  String _selectedPriority = 'All';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    Provider.of<IncidentProvider>(context, listen: false).filterIncidents(
      _searchController.text,
      _selectedStatus,
      _selectedPriority,
      _selectedCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or ID...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildDropdown('Status', ['All', ...AppConstants.statuses], _selectedStatus, (val) {
                  setState(() => _selectedStatus = val!);
                  _applyFilters();
                }),
                const SizedBox(width: 12),
                _buildDropdown('Priority', ['All', ...AppConstants.priorities], _selectedPriority, (val) {
                  setState(() => _selectedPriority = val!);
                  _applyFilters();
                }),
                const SizedBox(width: 12),
                _buildDropdown('Category', ['All', ...AppConstants.categories], _selectedCategory, (val) {
                  setState(() => _selectedCategory = val!);
                  _applyFilters();
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<IncidentProvider>(
              builder: (context, provider, child) {
                if (provider.incidents.isEmpty) {
                  return const Center(child: Text('No matching incidents found.'));
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
                          MaterialPageRoute(builder: (context) => IncidentDetailsScreen(incident: incident)),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String value, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
