import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/faculty_screens/provider/faculty_attendance_data_provider.dart';
import 'package:summer_project/student_screens/screens/attendance/widgets/attendance_count_display_widget.dart';

import '../../../../constants/constants.dart';

class FacultyStudentStatScreen extends StatelessWidget {
  const FacultyStudentStatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Student Stats List',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamilySans),
            ),
          ),
          Consumer<FacultyAttendanceDataProvider>(
            builder: (context, value, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: value.attendanceStatsList.isNotEmpty
                      ? value.attendanceStatsList.length
                      : 0,
                  itemBuilder: (context, index) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          Text(
                            value.attendanceStatsList[index].roll__roll,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: fontFamilySans,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                AttendanceCountDisplayWidget(
                                  title: 'Present',
                                  count: value.attendanceStatsList[index]
                                      .total_attendance,
                                  countTextSize: 20,
                                ),
                                AttendanceCountDisplayWidget(
                                  title: 'Absent',
                                  count: value.attendanceStatsList[index]
                                          .total_classes -
                                      value.attendanceStatsList[index]
                                          .total_attendance,
                                  countTextSize: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Material(
                                    color: Colors.grey.shade200,
                                    elevation: 10,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          '${value.attendanceStatsList[index].attendance_percentage}%',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontFamily: fontFamilySans,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
