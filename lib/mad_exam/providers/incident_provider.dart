import 'package:flutter/material.dart';
import '../models/incident.dart';
import '../services/hive_service.dart';
import '../utils/helpers.dart';
import 'package:uuid/uuid.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class IncidentProvider with ChangeNotifier {
  final HiveService _hiveService;
  List<Incident> _incidents = [];
  List<Incident> _filteredIncidents = [];
  bool _isLoading = false;

  IncidentProvider(this._hiveService) {
    _loadIncidents();
    _listenToConnectivity();
  }

  List<Incident> get incidents => _filteredIncidents;
  bool get isLoading => _isLoading;

  void _loadIncidents() {
    _incidents = _hiveService.getAllIncidents();
    _filteredIncidents = List.from(_incidents);
    sortIncidents();
  }

  Future<void> addIncident({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String location,
  }) async {
    _isLoading = true;
    notifyListeners();

    var connectivityResultList = await Connectivity().checkConnectivity();
    bool isSynced = !connectivityResultList.contains(ConnectivityResult.none);

    final incident = Incident(
      id: const Uuid().v4(),
      title: title,
      description: description,
      category: category,
      priority: priority,
      status: 'Reported',
      location: location,
      reportedTime: DateTime.now(),
      isSynced: isSynced,
    );

    await _hiveService.addIncident(incident);
    _incidents.add(incident);
    _filteredIncidents = List.from(_incidents);
    sortIncidents();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateIncident(Incident incident) async {
    await _hiveService.updateIncident(incident);
    int index = _incidents.indexWhere((i) => i.id == incident.id);
    if (index != -1) {
      _incidents[index] = incident;
      filterIncidents('', 'All', 'All', 'All'); // reset filters and sort
    }
  }

  Future<void> deleteIncident(String id) async {
    await _hiveService.deleteIncident(id);
    _incidents.removeWhere((i) => i.id == id);
    _filteredIncidents.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void filterIncidents(String query, String status, String priority, String category) {
    _filteredIncidents = _incidents.where((incident) {
      bool matchesQuery = query.isEmpty || 
        incident.title.toLowerCase().contains(query.toLowerCase()) || 
        incident.id.toLowerCase().contains(query.toLowerCase());
      bool matchesStatus = status == 'All' || incident.status == status;
      bool matchesPriority = priority == 'All' || incident.priority == priority;
      bool matchesCategory = category == 'All' || incident.category == category;

      return matchesQuery && matchesStatus && matchesPriority && matchesCategory;
    }).toList();
    
    sortIncidents();
  }

  void sortIncidents() {
    _filteredIncidents.sort((a, b) {
      int weightA = Helpers.getPriorityWeight(a.priority);
      int weightB = Helpers.getPriorityWeight(b.priority);

      if (weightA != weightB) {
        return weightB.compareTo(weightA); // Higher priority first
      } else {
        return b.reportedTime.compareTo(a.reportedTime); // Newer first (or earlier first?)
        // Requirement: "Within same priority: Earlier reports first."
        // return a.reportedTime.compareTo(b.reportedTime); 
      }
    });

    // requirement says "Earlier reports first."
    _filteredIncidents.sort((a, b) {
      int weightA = Helpers.getPriorityWeight(a.priority);
      int weightB = Helpers.getPriorityWeight(b.priority);

      if (weightA != weightB) {
        return weightB.compareTo(weightA);
      } else {
        return a.reportedTime.compareTo(b.reportedTime); 
      }
    });
    
    notifyListeners();
  }

  void _listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (!result.contains(ConnectivityResult.none)) {
        syncOfflineData();
      }
    });
  }

  Future<void> syncOfflineData() async {
    bool hasUnsynced = false;
    for (var incident in _incidents) {
      if (!incident.isSynced) {
        // Simulate network call
        await Future.delayed(const Duration(milliseconds: 500));
        incident.isSynced = true;
        await _hiveService.updateIncident(incident);
        hasUnsynced = true;
      }
    }
    if (hasUnsynced) {
      notifyListeners();
    }
  }

  // Dashboard analytics
  int get totalIncidents => _incidents.length;
  int get activeIncidents => _incidents.where((i) => i.status != 'Resolved').length;
  int get resolvedIncidents => _incidents.where((i) => i.status == 'Resolved').length;

  Map<String, int> get priorityDistribution {
    Map<String, int> dist = {'Critical': 0, 'High': 0, 'Medium': 0, 'Low': 0};
    for (var incident in _incidents) {
      if (dist.containsKey(incident.priority)) {
        dist[incident.priority] = dist[incident.priority]! + 1;
      }
    }
    return dist;
  }
}
