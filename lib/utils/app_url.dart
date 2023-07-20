import 'dotenv.dart';

class AppUrl {
  static final String baseURL = DotenvVar.baseUrl;
  //student urls
  static const String studentUrl = 'student';
  static const String studentLogin = "$studentUrl/login";
  static const String studentRegister = "$studentUrl/register/";
  static const String getStudentwithEmail = "$studentUrl/get/";
  static const String getStudentCourse = "$studentUrl/course";
  //student attendance urls
  static const String markAttendance = "$studentUrl/attendance";
  static const String getAttendance = "$studentUrl/attendance/";
  static const String faceCamera = "$studentUrl/face/verification/";

  //faculty urls
  static const String facultyUrl = 'faculty';
  static const String getFaculty = "$facultyUrl/get";
  static const String facultyCodeStatus = "$facultyUrl/faculty/code/status/";
  static const String facultyLogin = "$facultyUrl/login";
  static const String facultyBatchCourse = "$facultyUrl/batch/course";
  static const String facultyBatchCourseAttendance =
      "$facultyUrl/batch/course/attendance";

  //common urls
  static const String otpGenerate = "$studentUrl/otp/generate/";
  static const String otpVerify = "$studentUrl/otp/verify/";
  static const String forgotPassword = "$studentUrl/forgot_password/";
}
