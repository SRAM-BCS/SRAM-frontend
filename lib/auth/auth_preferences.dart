import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:summer_project/auth/model/student_user_model.dart';

class UserPreferences {
  static const storage = FlutterSecureStorage();
  void saveStudentUser(StudentUserModel user) async {
    await storage.write(key: 'student_user', value: user.toJson());
    // Make another write function for token later
  }

  Future<StudentUserModel> getUser() async {
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

  void removeUser() async {
    storage.delete(key: 'student_user');
  }

  // Future<String> getToken(args) async {
  //   final SharedPreferences storage = await SharedPreferences.getInstance();
  //   String token = storage.getString("token");
  //   return token;
  // }
}
