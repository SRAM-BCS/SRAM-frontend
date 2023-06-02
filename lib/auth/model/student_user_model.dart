import 'dart:convert';

class StudentUserModel {
  String id;
  String name;
  String email;
  String password;
  String profileImage;
  String rollNo;
  String batch;
  int yearOfAddmission;

  StudentUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.profileImage,
    required this.rollNo,
    required this.batch,
    required this.yearOfAddmission,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profileImage': profileImage,
      'rollNo': rollNo,
      'batch': batch,
      'yearOfAddmission': yearOfAddmission,
    };
  }

  factory StudentUserModel.fromMap(Map<String, dynamic> map) {
    return StudentUserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      profileImage: map['profileImage'] ?? '',
      rollNo: map['rollNo'] ?? '',
      batch: map['batch'] ?? '',
      yearOfAddmission: map['yearOfAddmission']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentUserModel.fromJson(String source) =>
      StudentUserModel.fromMap(json.decode(source));
}
