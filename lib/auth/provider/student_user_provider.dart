import 'package:flutter/material.dart';

import '../../models/student_user_model.dart';

class StudentUserProvider extends ChangeNotifier {
  StudentUserModel _user = StudentUserModel(
      name: '',
      rollNo: '',
      batch: '',
      yearOfAddmission: 0,
      password: '',
      profileImage: '',
      id: '',
      email: '');

  StudentUserModel get user => _user;

  void setUser(StudentUserModel user) {
    _user = user;
    notifyListeners();
  }
}
