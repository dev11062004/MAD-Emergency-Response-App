import 'package:hive/hive.dart';

part 'incident.g.dart';

@HiveType(typeId: 0)
class Incident extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String category;

  @HiveField(4)
  String priority;

  @HiveField(5)
  String status;

  @HiveField(6)
  String location;

  @HiveField(7)
  String? assignedResponder;

  @HiveField(8)
  DateTime reportedTime;

  @HiveField(9)
  bool isSynced;

  Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    required this.location,
    this.assignedResponder,
    required this.reportedTime,
    this.isSynced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'status': status,
      'location': location,
      'assignedResponder': assignedResponder,
      'reportedTime': reportedTime.toIso8601String(),
      'isSynced': isSynced,
    };
  }

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      priority: map['priority'] ?? '',
      status: map['status'] ?? '',
      location: map['location'] ?? '',
      assignedResponder: map['assignedResponder'],
      reportedTime: DateTime.parse(map['reportedTime']),
      isSynced: map['isSynced'] ?? false,
    );
  }
}
