import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/constants/routing_constants.dart';
import 'package:summer_project/student_screens/provider/mark_attendance_provider.dart';

class CourseTile extends StatelessWidget {
  final String courseName;
  final String courseCode;
  final String facultyName;
  final String facultyEmail;
  final String facultyCode;
  bool isActive;
  CourseTile({
    Key? key,
    required this.courseName,
    required this.courseCode,
    required this.facultyName,
    required this.facultyEmail,
    required this.facultyCode,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markAttendanceProvider =
        Provider.of<MarkAttendanceProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          markAttendanceProvider.setCourseCode(courseCode);
          markAttendanceProvider.setTeacherCode(facultyCode);

          GoRouter.of(context).pushNamed(
            RoutingConstants.attendanceDetailScreenRouteName,
          );
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseName,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: fontFamilySans,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  courseCode,
                  style: TextStyle(
                      fontFamily: fontFamilySans,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
                Text(
                  facultyName,
                  style: TextStyle(
                      fontFamily: fontFamilySans,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
