import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:developer' as dev;
import 'dart:convert';

import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/models/faculty_user_model.dart';
import 'package:summer_project/utils/http_response_handle.dart';

import '../../utils/app_url.dart';
import '../provider/faculty_provider.dart';

class FacultyServices {
  final commonPreferences = CommonPreferences();

  Future<int> getFaculty({required BuildContext context}) async {
    int statusCode = 0;
    try {
      var jwt = await commonPreferences.getJwt();
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': jwt
      };

      final response =
          await http.get(Uri.parse(AppUrl.getFaculty), headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'Get Faculty',
          onSuccessMsg: 'Faculty Get SuccessFull',
          response: response,
          onSuccess: () {
            statusCode = response.statusCode;
            final data = jsonDecode(response.body);
            Provider.of<FacultyProvider>(context, listen: false)
                .setUser(FacultyUserModel.fromMap(data));
            dev.log(data.toString(), name: 'Get Faculty Response');
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Get Faculty Error');
    }
    return statusCode;
  }
}
