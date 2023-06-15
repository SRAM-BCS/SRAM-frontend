import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:summer_project/auth/model/student_user_model.dart';
import 'package:summer_project/auth/model/teacher_user_model.dart';

class UserPreferences {
  static const storage = FlutterSecureStorage();
  void saveStudentUser(StudentUserModel user) async {
    await storage.write(key: 'student_user', value: user.toJson());
    // Make another write function for token later
  }

  Future<StudentUserModel> getStudentUser() async {
    final studentModel = await storage.read(key: 'student_user');

    if (studentModel != null) {
      return StudentUserModel.fromJson(studentModel);
    } else {
      return StudentUserModel(
          id: '',
          name: '',
          email: '',
          password: '',
          profileImage: '',
          rollNo: '',
          batch: '',
          yearOfAddmission: 0);
    }
  }

  void removeUser(String key) async {
    storage.delete(key: key);
  }

  // Future<String> getToken(args) async {
  //   final SharedPreferences storage = await SharedPreferences.getInstance();
  //   String token = storage.getString("token");
  //   return token;
  // }

  void saveTeacherUser(TeacherUserModel user) async {
    await storage.write(key: 'teacher_user', value: user.toJson());
  }

  Future<TeacherUserModel> getTeacherUser() async {
    final teacherModel = await storage.read(key: 'teacher_user');

    if (teacherModel != null) {
      return TeacherUserModel.fromJson(teacherModel);
    } else {
      return TeacherUserModel(
        id: '',
        name: '',
      );
    }
  }
}
