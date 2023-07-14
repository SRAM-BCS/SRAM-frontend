import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/student_screens/constants.dart';
import 'package:summer_project/student_screens/screens/mark_attendance/widgets/code_select_dropdown_widget.dart';

import '../../../provider/mark_attendance_provider.dart';
import '../../../provider/student_user_provider.dart';
import '../widgets/cicular_ripple_button.dart';
import 'package:intl/intl.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String formattedDate = '';
  String formattedTime = '';

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<MarkAttendanceProvider>(context);

    final studentProvider =
        Provider.of<StudentUserProvider>(context, listen: true).user;
    DateTime now = DateTime.now();
    formattedTime = DateFormat.jm().format(now);
    formattedDate = DateFormat.MMMMEEEEd().format(now);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/sram-logo.png',
                    ),
                    height: 50,
                    width: 100,
                  ),
                  Hero(
                    tag: 'profile_image',
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(studentProvider.profileImage),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              formattedTime,
              style: TextStyle(
                fontFamily: fontFamilySans,
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              formattedDate,
              style: TextStyle(
                fontFamily: fontFamilySans,
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const CicularRippleButton(),
            const SizedBox(
              height: 25,
            ),
            Text(
              '${attendanceProvider.courseCode}-${attendanceProvider.teacherCode}',
              style: TextStyle(
                  color: Colors.grey, fontSize: 15, fontFamily: fontFamilySans),
            ),
            const SizedBox(
              height: 25,
            ),
            const CodeSelectDropdownWidget(
              title: 'Course Code',
              isCourseCode: true,
            ),
            const CodeSelectDropdownWidget(
                title: 'Teacher Code', isTeacherCode: true),
          ],
        ),
      ),
    );
  }
}
