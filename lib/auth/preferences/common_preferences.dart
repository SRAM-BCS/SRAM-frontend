import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';

const _storage = FlutterSecureStorage();

class CommonPreferences {
  Future<String> getJwt() async {
    String? jwt = await _storage.read(key: 'jwt');
    if (jwt == null) {
      return '';
    }
    return jwt;
  }

  void setJwt(String jwt) async {
    await _storage.write(key: 'jwt', value: jwt);
  }

  void deleteJwt() async {
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'App_Progress');
    await _storage.delete(key: 'LoggedInUserLevel');
  }

  void setStudentAppProgress(AppProgressStatus appProgressStatus) async {
    await _storage.write(key: 'App_Progress', value: appProgressStatus.name);
  }

  Future<AppProgressStatus?> getStudentAppProgress() async {
    String? data = await _storage.read(key: 'App_Progress');

    if (data == AppProgressStatus.registered.name) {
      return AppProgressStatus.registered;
    } else if (data == AppProgressStatus.loggedIn.name) {
      return AppProgressStatus.loggedIn;
    } else if (data == AppProgressStatus.emailVerified.name) {
      return AppProgressStatus.emailVerified;
    } else {
      return null;
    }
  }

  void setCurrentLoggedInUserLevel(CurrentUserLevel currentUserLevel) async {
    await _storage.write(
        key: 'LoggedInUserLevel', value: currentUserLevel.name);
  }

  Future<CurrentUserLevel?> getCurrentLoggedInUserLevel() async {
    String? data = await _storage.read(key: 'LoggedInUserLevel');

    if (data == CurrentUserLevel.student.name) {
      return CurrentUserLevel.student;
    } else if (data == CurrentUserLevel.faculty.name) {
      return CurrentUserLevel.faculty;
    } else {
      return null;
    }
  }
}
