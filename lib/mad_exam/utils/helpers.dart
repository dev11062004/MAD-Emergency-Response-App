import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import 'package:flutter/material.dart';

class Helpers {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
  }

  static int getPriorityWeight(String priority) {
    switch (priority) {
      case 'Critical':
        return 4;
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      case 'Low':
        return 1;
      default:
        return 0;
    }
  }

  static Color getPriorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return AppColors.priorityCritical;
      case 'High':
        return AppColors.priorityHigh;
      case 'Medium':
        return AppColors.priorityMedium;
      case 'Low':
        return AppColors.priorityLow;
      default:
        return Colors.grey;
    }
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case 'Reported':
        return AppColors.statusReported;
      case 'In Progress':
        return AppColors.statusInProgress;
      case 'Resolved':
        return AppColors.statusResolved;
      default:
        return Colors.grey;
    }
  }
}
