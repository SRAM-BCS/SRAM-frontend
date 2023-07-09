import 'package:flutter/material.dart';
import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/student_screens/screens/attendance/widgets/course_tile.dart';

class CourseList extends StatelessWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          const CourseTile()
        ],
      ),
    );
  }
}
