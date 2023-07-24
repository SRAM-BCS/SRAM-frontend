import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;
import 'package:summer_project/faculty_screens/provider/faculty_attendance_data_provider.dart';
import 'package:summer_project/student_screens/constants.dart';

import '../../../../constants/constants.dart';

class FacultyStudentAttendanceListScreen extends StatefulWidget {
  final String date;
  const FacultyStudentAttendanceListScreen({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<FacultyStudentAttendanceListScreen> createState() =>
      _FacultyStudentAttendanceListScreenState();
}

class _FacultyStudentAttendanceListScreenState
    extends State<FacultyStudentAttendanceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ]),
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Roll Numbers Present',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamilySans,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<FacultyAttendanceDataProvider>(
                builder: (context, value, child) {
                  dev.log(
                      ' ${widget.date} == ${value.attendanceDayWiseMap[widget.date]}');
                  return AnimatedList(
                    shrinkWrap: true,
                    initialItemCount:
                        value.attendanceDayWiseMap[widget.date] == null
                            ? 0
                            : value.attendanceDayWiseMap[widget.date]!.length,
                    itemBuilder: (context, index, animation) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SlideTransition(
                          position: animation.drive(Tween(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          )),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  )
                                ]),
                            height: 20,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  value
                                      .attendanceDayWiseMap[widget.date]![index]
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: fontFamilySans,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
