import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/constants/routing_constants.dart';

import 'attendance_count_display_widget.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          GoRouter.of(context).pushNamed(
            RoutingConstants.attendanceDetailScreenRouteName,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: const Border.fromBorderSide(
              BorderSide(color: Colors.grey),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Software Engineering Course',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: fontFamilySans,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'Course Code',
                  style: TextStyle(
                      fontFamily: fontFamilySans,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'Proff. Santosh Singh Rathore',
                  style: TextStyle(
                      fontFamily: fontFamilySans,
                      fontWeight: FontWeight.normal),
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