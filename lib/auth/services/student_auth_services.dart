import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:summer_project/auth/preferences/student_user_preferences.dart';
import 'package:summer_project/common_widgets/toast.dart';
import 'package:summer_project/utils/app_url.dart';
import 'package:summer_project/utils/http_response_handle.dart';
import 'dart:developer' as dev;

final studentUserPreferences = StudentUserPreferences();

class StudentAuthServices {
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
          response: response,
          onSuccess: () {
            final data = jsonDecode(response.body);
            // studentUserPreferences.saveStudentJwt(data);
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
      var jwt = await studentUserPreferences.getStudentJwt();
      dev.log(jwt, name: "Reading JWT");
      Map<String, String> header = {'authorization': jwt};

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
}
