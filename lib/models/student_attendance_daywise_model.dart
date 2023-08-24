import 'dart:convert';

import 'package:intl/intl.dart';

class StudentAttendanceDayWiseModel {
  DateTime date;
  int present;
  StudentAttendanceDayWiseModel({
    required this.date,
    required this.present,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'present': present,
    };
  }

  factory StudentAttendanceDayWiseModel.fromMap(Map<String, dynamic> map) {
    return StudentAttendanceDayWiseModel(
      date: DateFormat('dd-MMM-yyyy').parse(map['date']),
      present: map['present']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentAttendanceDayWiseModel.fromJson(String source) =>
      StudentAttendanceDayWiseModel.fromMap(json.decode(source));
}
