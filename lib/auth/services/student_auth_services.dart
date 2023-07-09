import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:summer_project/models/student_user_model.dart';
import 'package:summer_project/auth/preferences/student_user_preferences.dart';
import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/common/widgets/toast.dart';
import 'package:summer_project/utils/app_url.dart';
import 'package:summer_project/utils/http_response_handle.dart';
import 'dart:developer' as dev;

class StudentAuthServices {
  final _studentUserPreference = StudentUserPreferences();
  final _commonPreference = CommonPreferences();

  Future<int> login({required String email, required String password}) async {
    int statusCode = 0;
    try {
      final response = await http.post(
        Uri.parse(AppUrl.studentLogin),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      httpResponseHandle(
          onSuccessMsgTag: 'Student Auth Services: Login ',
          onSuccessMsg: 'Student Login Successfull',
          response: response,
          onSuccess: () {
            final data = jsonDecode(response.body);
            // _studentUserPreference.saveStudentJwt(data);
            dev.log(data, name: "Student Login Response");
            statusCode = response.statusCode;
          });
    } catch (e) {
      dev.log(e.toString(), name: "Student Login Error");
    }
    return statusCode;
  }

  Future<int> register(
      {required String email,
      required String password,
      required String name,
      required String rollNo,
      required String batch,
      required String studentImagePath,
      required String studentIdImagePath}) async {
    int statusCode = 0;
    try {
      var jwt = await _commonPreference.getJwt();
      dev.log(jwt, name: "Reading JWT");
      Map<String, String> header = {'Authorization': jwt};

      final request =
          http.MultipartRequest('POST', Uri.parse(AppUrl.studentRegister));
      request.headers.addAll(header);
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['name'] = name;
      request.fields['rollNo'] = rollNo;
      request.fields['batch'] = batch;
      request.files.add(
        await http.MultipartFile.fromPath('media', studentImagePath),
      );
      request.files.add(
        await http.MultipartFile.fromPath('media', studentIdImagePath),
      );

      final res = await request.send();

      if (res.statusCode == 201) {
        statusCode = 201;
        showToast(msg: 'Login Successfull');

        dev.log('Registration Successfull', name: 'Registration Response');
      }
      if (res.statusCode == 500) {
        statusCode = 500;
        dev.log('RegistrationFailed', name: 'Registration Response');
      }
    } catch (e) {
      dev.log(e.toString(), name: 'Student Auth Services: Register Error');
    }
    return statusCode;
  }

  Future<StudentUserModel?> getStudent() async {
    StudentUserModel? studentData;
    try {
      var jwt = await _commonPreference.getJwt();
      dev.log(jwt, name: "Reading JWT");
      Map<String, String> header = {'Authorization': jwt};
      final response = await http.get(Uri.parse(AppUrl.getStudentwithEmail),
          headers: header);
      httpResponseHandle(
          onSuccessMsgTag: 'Student Auth Services: Get Student ',
          onSuccessMsg: 'Student Get Successfull',
          response: response,
          onSuccess: () {
            studentData = StudentUserModel.fromJson(response.body);
            dev.log(response.body, name: "Student Get Response");
          });
    } catch (e) {
      dev.log(e.toString(), name: "Student Get Error");
    }
    return studentData;
  }
}
