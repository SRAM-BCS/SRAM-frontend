import 'dart:convert';

import 'package:summer_project/faculty_screens/models/attendance_day_wise.dart';
import 'package:summer_project/faculty_screens/models/attendance_stats_model.dart';

class FacultyAttendanceDetailModel {
  final List<AttendanceStatsModel> attendanceStats;
  final List<AttendanceDayWise> attendanceDayWise;

  FacultyAttendanceDetailModel({
    required this.attendanceStats,
    required this.attendanceDayWise,
  });

  Map<String, dynamic> toMap() {
    return {
      'attendanceStats': attendanceStats.map((x) => x.toMap()).toList(),
      'attendanceDayWise': attendanceDayWise.map((x) => x.toMap()).toList(),
    };
  }

  factory FacultyAttendanceDetailModel.fromMap(Map<String, dynamic> map) {
    return FacultyAttendanceDetailModel(
      attendanceStats: List<AttendanceStatsModel>.from(
          map['attendanceStats']?.map((x) => AttendanceStatsModel.fromMap(x))),
      attendanceDayWise: List<AttendanceDayWise>.from(
          map['attendanceDayWise']?.entries.map((entry) {
                return AttendanceDayWise.fromMap(entry.key, entry.value);
              }) ??
              []),
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyAttendanceDetailModel.fromJson(String source) =>
      FacultyAttendanceDetailModel.fromMap(json.decode(source));
}
