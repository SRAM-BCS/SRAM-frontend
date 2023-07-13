import 'dart:convert';

class FacultyUserModel {
  final String name;
  final String email;
  final String code;
  final bool isActive;
  FacultyUserModel({
    required this.name,
    required this.email,
    required this.code,
    required this.isActive,
  });

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
      isActive: map['isActive'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyUserModel.fromJson(String source) =>
      FacultyUserModel.fromMap(json.decode(source));
}
