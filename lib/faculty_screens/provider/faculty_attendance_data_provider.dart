import 'package:flutter/material.dart';
import 'package:summer_project/faculty_screens/models/attendance_day_wise.dart';
import 'package:summer_project/faculty_screens/models/attendance_stats_model.dart';
import 'package:summer_project/faculty_screens/models/faculty_attendance_detail_model.dart';
import 'package:summer_project/faculty_screens/services/faculty_attendance_services.dart';

class FacultyAttendanceDataProvider extends ChangeNotifier {
  final facultyAttendanceServices = FacultyAttendanceServices();
  FacultyAttendanceDetailModel? _facultyAttendanceDetailModel;
  List<AttendanceStatsModel> _attendanceStatsList = [];
  List<AttendanceDayWise> _attendanceDaywiseList = [];
  Map<String, List<dynamic>> _attendanceDayWiseMap = {};
  String? checkAttendanceForDate;
  bool _isLoading = true;

  FacultyAttendanceDetailModel? get facultyAttendanceDetailModel =>
      _facultyAttendanceDetailModel;

  List<AttendanceStatsModel> get attendanceStatsList => _attendanceStatsList;
  List<AttendanceDayWise> get attendanceDaywiseList => _attendanceDaywiseList;
  Map<String, List<dynamic>> get attendanceDayWiseMap => _attendanceDayWiseMap;
  String? get getCheckAttendanceForDate => checkAttendanceForDate;
  bool get isLoading => _isLoading;

  void callAttendanceDataApi(
      {required String courseCode,
      required String batchCode,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    await facultyAttendanceServices.facultyBatchCourseAttendance(
        courseCode: courseCode, batchCode: batchCode, context: context);

    _isLoading = false;
    notifyListeners();
  }

  void setFacultyAttendanceDetailModel(
      FacultyAttendanceDetailModel facultyAttendanceDetailModel) {
    _facultyAttendanceDetailModel = facultyAttendanceDetailModel;
    _attendanceDaywiseList = _facultyAttendanceDetailModel!.attendanceDayWise;
    _attendanceStatsList = _facultyAttendanceDetailModel!.attendanceStats;
    _attendanceDayWiseMap = _facultyAttendanceDetailModel!.attendanceDayWiseMap;
    notifyListeners();
  }

  void setCheckAttendanceForDate({required String date}) {
    checkAttendanceForDate = date;
    notifyListeners();
  }
}
