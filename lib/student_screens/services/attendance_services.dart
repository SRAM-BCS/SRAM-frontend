import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:summer_project/common/widgets/toast.dart';
import 'package:summer_project/models/student_attendance_data_model.dart';
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
      final response = await http.post(
          Uri.parse('${AppUrl.baseURL}${AppUrl.markAttendance}'),
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
            showToast(msg: 'Attendance Marked');
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Mark Attendance Error');
    }
    return statusCode;
  }

  Future<StudentAttendanceDataModel?> getAttendance(
      {required String faculty, required String course}) async {
    StudentAttendanceDataModel? studentAttendanceDataModel;
    try {
      var jwt = await commonPreferences.getJwt();
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': jwt
      };
      final response = await http.get(
          Uri.parse(
              '${AppUrl.baseURL}${AppUrl.getAttendance}?faculty=$faculty&course=$course'),
          headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'Attendance Service - GetAttendance',
          onSuccessMsg: 'Attendance Fetched',
          response: response,
          onSuccess: () {
            dev.log(response.body, name: 'Student Get Attendance Response');

            if (response.body.isNotEmpty) {
              studentAttendanceDataModel = StudentAttendanceDataModel.fromJson(
                  jsonEncode(jsonDecode(response.body)['data']));
            }
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Get Attendance Error');
    }
    return studentAttendanceDataModel;
  }

  Future<int> faceVerification({required String imagePath}) async {
    int statusCode = 0;
    try {
      var jwt = await commonPreferences.getJwt();
      Map<String, String> header = {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': jwt
      };
      final request = http.MultipartRequest(
          'POST', Uri.parse('${AppUrl.baseURL}${AppUrl.faceCamera}'));
      request.headers.addAll(header);
      request.files.add(
        await http.MultipartFile.fromPath('image_file', imagePath),
      );
      dev.log('face image sent');
      final res = await request.send();
      dev.log(jsonDecode(await res.stream.bytesToString())['message'],
          name: 'Face Verification Status');
      if (res.statusCode == 200) {
        statusCode = 200;

        showToast(msg: 'Face Verified');
      } else if (res.statusCode == 401) {
        statusCode = 401;
      } else if (res.statusCode == 404) {
        statusCode = 404;
      } else {
        showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      dev.log(e.toString(), name: 'Face Verification Error');
    }
    return statusCode;
  }
}
