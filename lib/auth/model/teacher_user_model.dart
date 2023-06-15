import 'dart:convert';

class TeacherUserModel {
  String id;
  String name;
  TeacherUserModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TeacherUserModel.fromMap(Map<String, dynamic> map) {
    return TeacherUserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherUserModel.fromJson(String source) =>
      TeacherUserModel.fromMap(json.decode(source));
}
