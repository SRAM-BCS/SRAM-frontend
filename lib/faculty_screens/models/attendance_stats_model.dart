import 'dart:convert';

class AttendanceStatsModel {
  final String roll__roll;
  final int total_attendance;
  final int total_classes;
  final int attendance_percentage;
  AttendanceStatsModel({
    required this.roll__roll,
    required this.total_attendance,
    required this.total_classes,
    required this.attendance_percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'roll__roll': roll__roll,
      'total_attendance': total_attendance,
      'total_classes': total_classes,
      'attendance_percentage': attendance_percentage,
    };
  }

  factory AttendanceStatsModel.fromMap(Map<String, dynamic> map) {
    return AttendanceStatsModel(
      roll__roll: map['roll__roll'] ?? '',
      total_attendance: map['total_attendance']?.toInt() ?? 0,
      total_classes: map['total_classes']?.toInt() ?? 0,
      attendance_percentage: map['attendance_percentage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceStatsModel.fromJson(String source) =>
      AttendanceStatsModel.fromMap(json.decode(source));
}
