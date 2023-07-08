import 'dart:convert';

class AttendanceModel {
  // ignore: non_constant_identifier_names
  final String BCF_id;
  final String roll;
  final String date;
  final String classroom;
  final String created;
  final String updated;
  AttendanceModel({
    // ignore: non_constant_identifier_names
    required this.BCF_id,
    required this.roll,
    required this.date,
    required this.classroom,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'BCF_id': BCF_id,
      'roll': roll,
      'date': date,
      'classroom': classroom,
      'created': created,
      'updated': updated,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      BCF_id: map['BCF_id'] ?? '',
      roll: map['roll'] ?? '',
      date: map['date'] ?? '',
      classroom: map['classroom'] ?? '',
      created: map['created'] ?? '',
      updated: map['updated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source));
}
