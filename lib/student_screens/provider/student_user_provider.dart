import 'package:flutter/material.dart';

import '../../models/student_user_model.dart';

class StudentUserProvider extends ChangeNotifier {
  StudentUserModel _user = StudentUserModel(
      name: '',
      roll: '',
      batch: '',
      profileImage: '',
      id: '',
      email: '',
      idImage: '',
      isActive: false,
      requestStatus: '');

  StudentUserModel get user => _user;

  void setUser(StudentUserModel user) {
    _user = user;
    notifyListeners();
  }
}
