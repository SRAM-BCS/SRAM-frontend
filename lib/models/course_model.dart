import 'dart:convert';

class CourseModel {
  final String name;
  final String code;
  CourseModel({
    required this.name,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));
}
