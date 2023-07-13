import 'dart:convert';

import 'package:summer_project/models/course_model.dart';
import 'package:summer_project/models/faculty_user_model.dart';

class StudentCourse {
  FacultyUserModel facultyUserModel;
  CourseModel courseModel;
  StudentCourse({
    required this.facultyUserModel,
    required this.courseModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'facultyUserModel': facultyUserModel.toMap(),
      'courseModel': courseModel.toMap(),
    };
  }

  factory StudentCourse.fromMap(Map<String, dynamic> map) {
    return StudentCourse(
      facultyUserModel: FacultyUserModel.fromMap(map['faculty']),
      courseModel: CourseModel.fromMap(map['course']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentCourse.fromJson(String source) =>
      StudentCourse.fromMap(json.decode(source));
}
