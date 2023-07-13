import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:summer_project/auth/constants.dart';
import 'package:summer_project/auth/models/register_form_model.dart';
import 'package:summer_project/models/student_user_model.dart';

const storage = FlutterSecureStorage();

class StudentUserPreferences {
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
          profileImage: '',
          roll: '',
          batch: '',
          idImage: '',
          isActive: false,
          requestStatus: '');
    }
  }

  void setStudentRegisterDetails(RegisterFormModel registerFormModel) async {
    await storage.write(
        key: 'student_register_details', value: registerFormModel.toJson());
  }
}
