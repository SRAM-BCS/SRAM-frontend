import 'dart:developer' as dev;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FacultyAttendancePreferences {
  final storage = const FlutterSecureStorage();

  void setFacultyBatchAttendanceDetails({
    required String batch,
    required String course,
    required String json,
  }) async {
    await storage.write(
      key: '$batch$course',
      value: json,
    );

    dev.log('Faculty Batch Attendance Details Set',
        name: 'Faculty Preferences');
  }

  Future<String?> getFacultyBatchAttendanceDetails({
    required String batch,
    required String course,
  }) async {
    var data = await storage.read(key: '$batch$course');
    if (data != null) {
      dev.log('Faculty Batch Attendance Details Get',
          name: 'Faculty Preferences');
      return data;
    }
    return null;
  }
}
