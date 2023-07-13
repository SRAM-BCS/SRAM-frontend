import 'package:flutter/material.dart';
import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/student_screens/screens/attendance/widgets/course_tile.dart';

import '../../../services/course_services.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final courseService = CourseServices();
  @override
  void initState() {
    courseService.getCourse();
    super.initState();
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
                'Course Attendance',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilySans),
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
