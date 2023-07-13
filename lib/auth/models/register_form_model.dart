import 'dart:convert';

class RegisterFormModel {
  String email;
  String password;
  String name;
  String roll;
  String batch;
  String profileImage;
  String idImage;
  RegisterFormModel({
    required this.email,
    required this.password,
    required this.name,
    required this.roll,
    required this.batch,
    required this.profileImage,
    required this.idImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'roll': roll,
      'batch': batch,
      'profileImage': profileImage,
      'idImage': idImage,
    };
  }

  factory RegisterFormModel.fromMap(Map<String, dynamic> map) {
    return RegisterFormModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      roll: map['roll'] ?? '',
      batch: map['batch'] ?? '',
      profileImage: map['profileImage'] ?? '',
      idImage: map['idImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterFormModel.fromJson(String source) =>
      RegisterFormModel.fromMap(json.decode(source));
}
