class AppUrl {
  static const String baseURL = 'http://127.0.0.1:8000/';
  //student urls
  static const String studentUrl = 'api/student';
  static const String studentLogin = "$baseURL$studentUrl/login/";
  static const String studentRegister = "$baseURL$studentUrl/registration/";
  static const String getStudentwithEmail = "$baseURL$studentUrl/get/";
  //student attendance urls
  static const String markAttendance = "$baseURL$studentUrl/attendance/";
  static const String getAttendance = "$baseURL$studentUrl/attendance/";

  //faculty urls
  static const String facultyUrl = 'api/faculty';
  static const String facultyCodeStatus =
      "$baseURL$facultyUrl/faculty/code/status/";
  static const String facultyLogin = "$baseURL$facultyUrl/login/";

  //common urls
  static const String otpGenerate = "$baseURL$studentUrl/otp/generate/";
  static const String otpVerify = "$baseURL$studentUrl/otp/verify/";
  static const String forgotPassword = "$baseURL$studentUrl/forgot_password/";
  static const String facultyBatchCourse = "$baseURL$facultyUrl/batch/course/";
}
