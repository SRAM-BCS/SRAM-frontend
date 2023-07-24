import 'package:flutter/material.dart';
import 'package:summer_project/common/widgets/toast.dart';

import 'package:summer_project/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        height: 120,
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
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(
                    Uri.parse(
                        'mailto:$facultyEmail?subject=Greetings&body=Hello%20Sir/Maam'),
                  )) {
                    showToast(msg: 'Cannot Launch Url');
                  }
                },
                child: Text(
                  facultyEmail,
                  style: TextStyle(
                      color: Colors.blue,
                      fontFamily: fontFamilySans,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
              ),
              Text(
                facultyCode,
                style: TextStyle(
                    fontFamily: fontFamilySans,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//  markAttendanceProvider.setCourseCode(courseCode);
//           markAttendanceProvider.setTeacherCode(facultyCode);

//           GoRouter.of(context).pushNamed(
//             RoutingConstants.attendanceDetailScreenRouteName,
//           );