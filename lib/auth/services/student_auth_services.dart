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
  // final _studentUserPreference = StudentUserPreferences();
  final _commonPreference = CommonPreferences();

  Future<int> login({required String email, required String password}) async {
    int statusCode = 0;
    try {
      Map<String, String> header = {
        "Content-Type": "application/json; charset=utf-8",
      };
      final response = await http.post(
        Uri.parse('${AppUrl.baseURL}${AppUrl.studentLogin}'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: header,
      );

      httpResponseHandle(
          onSuccessMsgTag: 'Student Auth Services: Login ',
          onSuccessMsg: 'Student Login Successfull',
          response: response,
          onSuccess: () {
            final data = jsonDecode(response.body);
            showToast(msg: data['message']);
            _commonPreference.setJwt(data['refresh_token']);
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
      Map<String, String> header = {
        "Content-Type": "application/json; charset=utf-8",
      };

      final request = http.MultipartRequest(
          'POST', Uri.parse('${AppUrl.baseURL}${AppUrl.studentRegister}'));
      request.headers.addAll(header);
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['name'] = name;
      request.fields['roll'] = rollNo;
      request.fields['batch'] = batch;
      dev.log(batch, name: "Batch");
      request.files.add(
        await http.MultipartFile.fromPath('profileImage', studentImagePath),
      );
      request.files.add(
        await http.MultipartFile.fromPath('idImage', studentIdImagePath),
      );

      final res = await request.send();

      if (res.statusCode == 201) {
        statusCode = 201;
        showToast(msg: 'Registration Request Sent');

        dev.log('Registration Request Sent', name: 'Registration Response');
      }
      if (res.statusCode == 400) {
        statusCode = 400;
        dev.log('RegistrationFailed', name: 'Registration Response');
        dev.log(await res.stream.bytesToString(),
            name: 'Registration Response');
      }
    } catch (e) {
      dev.log(e.toString(), name: 'Student Auth Services: Register Error');
    }
    return statusCode;
  }
}
