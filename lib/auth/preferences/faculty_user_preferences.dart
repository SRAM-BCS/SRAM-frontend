import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/faculty_user_model.dart';

class FacultyUserPreferences {
  static const storage = FlutterSecureStorage();
  void saveTeacherUser(FacultyUserModel user) async {
    await storage.write(key: 'teacher_user', value: user.toJson());
  }

  Future<FacultyUserModel> getTeacherUser() async {
    final teacherModel = await storage.read(key: 'teacher_user');

    if (teacherModel != null) {
      return FacultyUserModel.fromJson(teacherModel);
    } else {
      return FacultyUserModel(
        id: '',
        name: '',
      );
    }
  }
}
