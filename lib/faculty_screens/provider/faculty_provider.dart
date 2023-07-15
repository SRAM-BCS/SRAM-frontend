import 'package:flutter/material.dart';
import 'package:summer_project/models/faculty_user_model.dart';

class FacultyProvider extends ChangeNotifier {
  FacultyUserModel _user = FacultyUserModel(
    code: '',
    courses: [],
    created: '',
    email: '',
    isActive: false,
    name: '',
  );

  FacultyUserModel get user => _user;

  void setUser(FacultyUserModel user) {
    _user = user;
    notifyListeners();
  }
}
