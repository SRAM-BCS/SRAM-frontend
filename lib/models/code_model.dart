import 'dart:convert';

class CodeModel {
  final String uniqueCode;
  bool isActive;
  final String created;
  final String updated;
  CodeModel({
    required this.uniqueCode,
    required this.isActive,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'uniqueCode': uniqueCode,
      'isActive': isActive,
      'created': created,
      'updated': updated,
    };
  }

  factory CodeModel.fromMap(Map<String, dynamic> map) {
    return CodeModel(
      uniqueCode: map['uniqueCode'] ?? '',
      isActive: map['isActive'] ?? false,
      created: map['created'] ?? '',
      updated: map['updated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeModel.fromJson(String source) =>
      CodeModel.fromMap(json.decode(source));
}
