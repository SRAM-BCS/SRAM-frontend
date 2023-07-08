import 'dart:convert';

class FacultyUserModel {
  String id;
  String name;
  FacultyUserModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory FacultyUserModel.fromMap(Map<String, dynamic> map) {
    return FacultyUserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyUserModel.fromJson(String source) =>
      FacultyUserModel.fromMap(json.decode(source));
}
