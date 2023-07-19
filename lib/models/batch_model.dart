import 'dart:convert';

class BatchModel {
  final String title;
  final String code;
  BatchModel({
    required this.title,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'code': code,
    };
  }

  factory BatchModel.fromMap(Map<String, dynamic> map) {
    return BatchModel(
      title: map['title'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BatchModel.fromJson(String source) =>
      BatchModel.fromMap(json.decode(source));
}
