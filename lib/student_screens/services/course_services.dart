import 'package:http/http.dart' as http;
import 'package:summer_project/models/student_course_model.dart';
import 'package:summer_project/utils/http_response_handle.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import '../../auth/preferences/common_preferences.dart';
import '../../utils/app_url.dart';

class CourseServices {
  final _commonPreference = CommonPreferences();
  Future<List<StudentCourse>> getCourse() async {
    List<StudentCourse> studentCourseList = [];
    try {
      var jwt = await _commonPreference.getJwt();
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': jwt
      };
      final response = await http.get(
          Uri.parse('${AppUrl.baseURL}${AppUrl.getStudentCourse}'),
          headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'Course Data',
          onSuccessMsg: 'Course Data Fetched',
          response: response,
          onSuccess: () {
            final data = jsonDecode(response.body)['data'];
            for (var i in data) {
              studentCourseList.add(StudentCourse.fromMap(i));
            }
            dev.log(data.toString(), name: 'Course Data');
          });
    } catch (e) {
      dev.log(e.toString(), name: 'Get Course Error');
    }
    return studentCourseList;
  }
}
