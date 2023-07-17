import 'dart:convert';

import 'package:summer_project/models/course_model.dart';

class FacultyUserModel {
  final String name;
  final String email;
  final String code;
  final List<CourseModel> courses;
  final String created;
  final bool isActive;
  FacultyUserModel(
      {required this.name,
      required this.email,
      required this.code,
      required this.isActive,
      required this.courses,
      required this.created});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'code': code,
      'isActive': isActive,
    };
  }

  factory FacultyUserModel.fromMap(Map<String, dynamic> map) {
    return FacultyUserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      code: map['code'] ?? '',
      courses: List<CourseModel>.from(
          map['courses']?.map((x) => CourseModel.fromMap(x)) ?? []),
      isActive: map['isActive'] ?? false,
      created: map['created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyUserModel.fromJson(String source) =>
      FacultyUserModel.fromMap(json.decode(source));
}
