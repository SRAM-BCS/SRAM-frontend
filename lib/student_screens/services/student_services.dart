import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/student_screens/provider/student_user_provider.dart';
import 'dart:developer' as dev;
import 'dart:convert';

import '../../models/student_user_model.dart';
import '../../utils/app_url.dart';
import '../../utils/http_response_handle.dart';

class StudentServices {
  final _commonPreference = CommonPreferences();
  Future<StudentUserModel?> getStudent({required BuildContext context}) async {
    StudentUserModel? studentData;
    try {
      var jwt = await _commonPreference.getJwt();
      dev.log(jwt, name: "Reading JWT");
      Map<String, String> header = {'Authorization': jwt};
      final response = await http.get(
          Uri.parse('${AppUrl.baseURL}{AppUrl.getStudentwithEmail}'),
          headers: header);
      httpResponseHandle(
          onSuccessMsgTag: 'Student Auth Services: Get Student ',
          onSuccessMsg: 'Student Get Successfull',
          response: response,
          onSuccess: () {
            studentData = StudentUserModel.fromJson(response.body);
            if (studentData != null) {
              Provider.of<StudentUserProvider>(context, listen: false)
                  .setUser(studentData!);
            }
            dev.log(response.body, name: "Student Get Response");
          });
    } catch (e) {
      dev.log(e.toString(), name: "Student Get Error");
    }
    return studentData;
  }
}
