import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'dart:convert';

import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/utils/http_response_handle.dart';

import '../../utils/app_url.dart';

class FacultyAttendanceServices {
  final commonPreference = CommonPreferences();

  Future<int> toggleFacultyCode(
      {required String facultyCode, required String classRoom}) async {
    int statusCode = 0;
    try {
      var jwt = await commonPreference.getJwt();
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': jwt
      };

      final response = await http.post(
        Uri.parse(AppUrl.facultyCodeStatus),
        body: jsonEncode({
          'facultyCode': facultyCode,
          'classRoom': classRoom,
        }),
        headers: header,
      );

      httpResponseHandle(
          onSuccessMsgTag: 'Toggle Faculty Code',
          onSuccessMsg: 'Faculty Code Toggled SuccessFull',
          response: response,
          onSuccess: () {
            statusCode = response.statusCode;
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Toggle Faculty Code Error');
    }
    return statusCode;
  }

  Future<int> facultyBatchCourse({
    required String email,
  }) async {
    int statusCode = 0;
    try {
      var jwt = await commonPreference.getJwt();
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': jwt
      };
      final response =
          await http.get(Uri.parse(AppUrl.facultyBatchCourse), headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'Faculty Batch Course',
          onSuccessMsg: 'FacultyBatchCourse Get Success',
          response: response,
          onSuccess: () {
            statusCode = response.statusCode;
            final data = jsonDecode(response.body);
            dev.log(data.toString(), name: 'Faculty Batch Course');
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Faculty Batch Course Error');
    }
    return statusCode;
  }
}
