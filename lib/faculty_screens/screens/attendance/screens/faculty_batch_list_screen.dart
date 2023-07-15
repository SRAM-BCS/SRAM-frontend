import 'package:flutter/material.dart';
import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/faculty_screens/services/faculty_attendance_services.dart';
import 'package:summer_project/models/student_course_model.dart';

import '../../../../student_screens/screens/attendance/widgets/course_tile.dart';

class FacultyBatchListScreen extends StatefulWidget {
  const FacultyBatchListScreen({super.key});

  @override
  State<FacultyBatchListScreen> createState() => _FacultyBatchListScreenState();
}

class _FacultyBatchListScreenState extends State<FacultyBatchListScreen> {
  final facultyAttendanceServices = FacultyAttendanceServices();
  Future<List<StudentCourse>>? courseList;
  @override
  void initState() {
    getCourse();
    super.initState();
  }

  void getCourse() {
    // setState(() {
    //   courseList = courseService.getCourse();
    // });
//  facultyAttendanceServices.facultyBatchCourse(email: , courseCode: , batchCode: );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Course List',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilySans),
              ),
            ),
            const SizedBox(height: 20),
            CourseTile(
              courseCode: 'CN',
              courseName: 'Course Name',
              facultyCode: 'DR',
              facultyEmail: 'BCS',
              facultyName: 'Deepak Rai',
              isActive: true,
            )
          ],
        ),
      ),
    );
  }
}
