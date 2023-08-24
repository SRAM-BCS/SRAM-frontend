import 'dart:convert';

import 'package:summer_project/models/student_attendance_daywise_model.dart';

class StudentAttendanceDataModel {
  List<StudentAttendanceDayWiseModel> attendance;
  int present;
  int total_classes;
  int attendance_percentage;
  StudentAttendanceDataModel({
    required this.attendance,
    required this.present,
    required this.total_classes,
    required this.attendance_percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'attendance': attendance.map((x) => x.toMap()).toList(),
      'present': present,
      'total_classes': total_classes,
      'attendance_percentage': attendance_percentage,
    };
  }

  factory StudentAttendanceDataModel.fromMap(Map<String, dynamic> map) {
    return StudentAttendanceDataModel(
      attendance: List<StudentAttendanceDayWiseModel>.from(map['attendance']
          ?.map((x) => StudentAttendanceDayWiseModel.fromMap(x))),
      present: map['present']?.toInt() ?? 0,
      total_classes: map['total_classes']?.toInt() ?? 0,
      attendance_percentage: map['attendance_percentage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentAttendanceDataModel.fromJson(String source) =>
      StudentAttendanceDataModel.fromMap(json.decode(source));
}
