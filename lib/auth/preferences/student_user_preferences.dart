import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:summer_project/auth/constants.dart';
import 'package:summer_project/auth/models/student_user_model.dart';

const storage = FlutterSecureStorage();

class StudentUserPreferences {
  Future<String> getStudentJwt() async {
    String? studentJwt = await storage.read(key: 'student_jwt');
    if (studentJwt == null) {
      return '';
    }
    return studentJwt;
  }

  void saveStudentJwt(String jwt) async {
    await storage.write(key: 'student_jwt', value: jwt);
  }

  void removeStudentJwt() async {
    await storage.delete(key: 'student_jwt');
  }

  void readAdminApprovalStatus() async {
    await storage.read(key: 'admin_approval_status');
  }

  void setAdminApprovalStatus({required AdminApprovalStatus status}) async {
    await storage.write(key: 'admin_approval_status', value: status.toString());
  }

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
}
