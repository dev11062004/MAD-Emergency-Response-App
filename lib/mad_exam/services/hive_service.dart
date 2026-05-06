import 'package:hive_flutter/hive_flutter.dart';
import '../models/incident.dart';
import '../constants/app_constants.dart';

class HiveService {
  late Box<Incident> _incidentBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(IncidentAdapter());
    _incidentBox = await Hive.openBox<Incident>(AppConstants.hiveBoxName);
  }

  List<Incident> getAllIncidents() {
    return _incidentBox.values.toList();
  }

  Future<void> addIncident(Incident incident) async {
    await _incidentBox.put(incident.id, incident);
  }

  Future<void> updateIncident(Incident incident) async {
    await incident.save();
  }

  Future<void> deleteIncident(String id) async {
    await _incidentBox.delete(id);
  }

  Future<void> clearAll() async {
    await _incidentBox.clear();
  }
}
