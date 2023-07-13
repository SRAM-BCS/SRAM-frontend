import 'dart:convert';

class StudentUserModel {
  String id;
  String name;
  String email;
  String profileImage;
  String idImage;
  String requestStatus;
  bool isActive;
  String roll;
  String batch;

  StudentUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.idImage,
    required this.requestStatus,
    required this.isActive,
    required this.roll,
    required this.batch,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'idImage': idImage,
      'requestStatus': requestStatus,
      'isActive': isActive,
      'roll': roll,
      'batch': batch,
    };
  }

  factory StudentUserModel.fromMap(Map<String, dynamic> map) {
    return StudentUserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'] ?? '',
      idImage: map['idImage'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      isActive: map['isActive'] ?? false,
      roll: map['roll'] ?? '',
      batch: map['batch'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentUserModel.fromJson(String source) =>
      StudentUserModel.fromMap(json.decode(source));

  StudentUserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? idImage,
    String? requestStatus,
    bool? isActive,
    String? roll,
    String? batch,
  }) {
    return StudentUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      idImage: idImage ?? this.idImage,
      requestStatus: requestStatus ?? this.requestStatus,
      isActive: isActive ?? this.isActive,
      roll: roll ?? this.roll,
      batch: batch ?? this.batch,
    );
  }

  @override
  String toString() {
    return 'StudentUserModel(id: $id, name: $name, email: $email, profileImage: $profileImage, idImage: $idImage, requestStatus: $requestStatus, isActive: $isActive, roll: $roll, batch: $batch)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentUserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.profileImage == profileImage &&
        other.idImage == idImage &&
        other.requestStatus == requestStatus &&
        other.isActive == isActive &&
        other.roll == roll &&
        other.batch == batch;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        profileImage.hashCode ^
        idImage.hashCode ^
        requestStatus.hashCode ^
        isActive.hashCode ^
        roll.hashCode ^
        batch.hashCode;
  }
}
