import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:summer_project/utils/app_url.dart';
import 'package:summer_project/utils/http_response_handle.dart';

import '../../auth/preferences/common_preferences.dart';

class AttendanceServices {
  final commonPreferences = CommonPreferences();
  Future<int> markAttendance(
      {required String coursecode,
      required String classRoom,
      required String teachercode}) async {
    int statusCode = 0;
    try {
      var jwt = await commonPreferences.getJwt();
      Map<String, String> header = {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': jwt
      };
      final response = await http.post(Uri.parse(AppUrl.markAttendance),
          body: jsonEncode({
            'coursecode': coursecode,
            'classRoom': classRoom,
            'teachercode': teachercode,
          }),
          headers: header);

      dev.log('$classRoom $coursecode $teachercode');

      httpResponseHandle(
          onSuccessMsgTag: 'Attendance Service - MarkAttendance',
          onSuccessMsg: 'Attendance Marked',
          response: response,
          onSuccess: () {
            dev.log(response.body, name: 'Attendance Response');
            statusCode = response.statusCode;
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Mark Attendance Error');
    }
    return statusCode;
  }

  Future<int> getAttendance() async {
    int statusCode = 0;
    try {
      var jwt = await commonPreferences.getJwt();
      Map<String, String> header = {'Authorization': jwt};
      final response =
          await http.post(Uri.parse(AppUrl.getAttendance), headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'Attendance Service - GetAttendance',
          onSuccessMsg: 'Attendance Fetched',
          response: response,
          onSuccess: () {
            statusCode = response.statusCode;
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Get Attendance Error');
    }
    return statusCode;
  }
}
