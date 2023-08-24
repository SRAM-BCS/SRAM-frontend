import 'package:flutter/material.dart';
import 'package:summer_project/models/student_attendance_data_model.dart';
import 'package:summer_project/models/student_attendance_daywise_model.dart';

import '../services/attendance_services.dart';

class StudentAttendanceDataProvider extends ChangeNotifier {
  final studentAttendanceServices = AttendanceServices();
  StudentAttendanceDataModel? _studentAttendanceDataModel;
  List<StudentAttendanceDayWiseModel> _attendanceDaywiseList = [];
  String? checkAttendanceForDate;
  int _present = 0;
  int _total_classes = 0;
  int _attendance_percentage = 0;
  bool _isLoading = true;

  StudentAttendanceDataModel? get studentAttendanceDataModel =>
      _studentAttendanceDataModel;

  List<StudentAttendanceDayWiseModel> get attendanceDaywiseList =>
      _attendanceDaywiseList;
  int get getPresent => _present;
  int get getTotalClasses => _total_classes;
  int get getAttendancePercentage => _attendance_percentage;
  String? get getCheckAttendanceForDate => checkAttendanceForDate;
  bool get isLoading => _isLoading;

  void callAttendanceDataApi(
      {required String course,
      required String faculty,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    await studentAttendanceServices.getAttendance(
        faculty: faculty, course: course);

    _isLoading = false;
    notifyListeners();
  }

  void setFacultyAttendanceDetailModel(
      StudentAttendanceDataModel studentAttendanceDataModel) {
    _studentAttendanceDataModel = studentAttendanceDataModel;
    _attendanceDaywiseList = _studentAttendanceDataModel!.attendance;
    _present = _studentAttendanceDataModel!.present;
    _total_classes = _studentAttendanceDataModel!.total_classes;
    _attendance_percentage = _studentAttendanceDataModel!.attendance_percentage;
    notifyListeners();
  }
}
