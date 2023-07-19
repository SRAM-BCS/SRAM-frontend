import 'dart:convert';

import 'package:summer_project/models/course_model.dart';

import 'batch_model.dart';

class FacultyCourseModel {
  CourseModel course;
  BatchModel batch;
  FacultyCourseModel({
    required this.course,
    required this.batch,
  });

  Map<String, dynamic> toMap() {
    return {
      'course': course.toMap(),
      'batch': batch.toMap(),
    };
  }

  factory FacultyCourseModel.fromMap(Map<String, dynamic> map) {
    return FacultyCourseModel(
      course: CourseModel.fromMap(map['course']),
      batch: BatchModel.fromMap(map['batch']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyCourseModel.fromJson(String source) =>
      FacultyCourseModel.fromMap(json.decode(source));
}
