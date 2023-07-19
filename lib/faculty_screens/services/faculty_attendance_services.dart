import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'dart:convert';

import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/faculty_screens/preferences/faculty_attendance_preferences.dart';
import 'package:summer_project/models/faculty_course_model.dart';
import 'package:summer_project/utils/http_response_handle.dart';

import '../../utils/app_url.dart';
import '../models/faculty_attendance_detail_model.dart';

class FacultyAttendanceServices {
  final commonPreference = CommonPreferences();
  final facultyAttendancePreference = FacultyAttendancePreferences();

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

  Future<List<FacultyCourseModel>> facultyBatchCourse({
    required String email,
  }) async {
    List<FacultyCourseModel> facultyCourseList = [];
    try {
      var jwt = await commonPreference.getJwt();
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': jwt
      };
      final response = await http.get(
          Uri.parse('${AppUrl.facultyBatchCourse}?email=$email'),
          headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'Faculty Batch Course',
          onSuccessMsg: 'FacultyBatchCourse Get Success',
          response: response,
          onSuccess: () {
            final data = jsonDecode(response.body)['data'];
            dev.log(data.toString(), name: 'Faculty Batch Course');

            for (var course in data) {
              facultyCourseList.add(FacultyCourseModel.fromMap(course));
            }
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Faculty Batch Course Error');
    }
    return facultyCourseList;
  }

  Future<FacultyAttendanceDetailModel?> facultyBatchCourseAttendance(
      {required String courseCode, required String batchCode}) async {
    FacultyAttendanceDetailModel? facultyAttendanceDetailModel;
    try {
      var jwt = await commonPreference.getJwt();
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': jwt
      };

      final response =
          await http.post(Uri.parse(AppUrl.facultyBatchCourseAttendance),
              body: jsonEncode(
                {'courseCode': courseCode, 'batchCode': batchCode},
              ),
              headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'facultyBatchCourseAttendance ',
          onSuccessMsg: 'facultyBatchCourseAttendance GET success',
          response: response,
          onSuccess: () {
            final data = jsonDecode(response.body)['data'];
            dev.log(data.toString(), name: 'facultyBatchCourseAttendance');

            if (data != null) {
              facultyAttendanceDetailModel =
                  FacultyAttendanceDetailModel.fromJson(jsonEncode(data));
            }
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Faculty Get Attendance Detail Error');
    }
    return facultyAttendanceDetailModel;
  }
}
