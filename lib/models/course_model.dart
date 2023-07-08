import 'dart:convert';

class CourseModel {
  final String id;
  final String name;
  final String code;
  final String batches;
  final String created;
  final String updated;
  CourseModel({
    required this.id,
    required this.name,
    required this.code,
    required this.batches,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'batches': batches,
      'created': created,
      'updated': updated,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      batches: map['batches'] ?? '',
      created: map['created'] ?? '',
      updated: map['updated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));
}
