import 'dart:convert';
import 'package:intl/intl.dart';

class AttendanceDayWise {
  final DateTime date;
  final List<dynamic> rollNoPresent;
  AttendanceDayWise({
    required this.date,
    required this.rollNoPresent,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'rollNoPresent': rollNoPresent,
    };
  }

  factory AttendanceDayWise.fromMap(String date, List<dynamic> rollNoPresent) {
    return AttendanceDayWise(
      date: DateFormat('dd-MMM-yyyy').parse(date),
      rollNoPresent: List<dynamic>.from(rollNoPresent),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceDayWise.fromJson(String source) =>
      AttendanceDayWise.fromMap(
          json.decode(source)['date'], json.decode(source)['rollNoPresent']);
}
