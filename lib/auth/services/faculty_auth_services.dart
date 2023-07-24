import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'dart:convert';

import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/common/widgets/toast.dart';
import 'package:summer_project/utils/http_response_handle.dart';

import '../../utils/app_url.dart';

class FacultyAuthServices {
  final commonPreference = CommonPreferences();
  Future<int> login({required String email, required String password}) async {
    int statusCode = 0;
    try {
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
      };

      final response = await http.post(
        Uri.parse('${AppUrl.baseURL}${AppUrl.facultyLogin}'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: header,
      );

      httpResponseHandle(
          onSuccessMsgTag: 'Faculty Login',
          onSuccessMsg: 'Faculty Login SuccessFull',
          response: response,
          onSuccess: () {
            statusCode = response.statusCode;

            final data = jsonDecode(response.body);
            showToast(msg: data['message']);
            commonPreference.setJwt(data['token']);
            dev.log(data['token'], name: 'Faculty Login');
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Faculty Login Error');
    }
    return statusCode;
  }
}
