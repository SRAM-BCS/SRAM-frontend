import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:summer_project/models/student_attendance_data_model.dart';
import 'package:summer_project/models/student_attendance_daywise_model.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:summer_project/student_screens/screens/attendance/widgets/attendance_count_display_widget.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/routing_constants.dart';
import '../../../services/attendance_services.dart';

class AttendanceDetailScreen extends StatefulWidget {
  final String faculty;
  final String course;
  const AttendanceDetailScreen({
    Key? key,
    required this.faculty,
    required this.course,
  }) : super(key: key);

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final attendanceServices = AttendanceServices();
  Future<StudentAttendanceDataModel?>? studentAttendanceDataModel;

  int present = 0;
  int absent = 0;
  int totalClasses = 0;
  int attendancePercenetage = 0;
  @override
  void initState() {
    getAttendanceData();

    super.initState();
  }

  void getAttendanceData() {
    dev.log('Faculty = ${widget.faculty} Course = ${widget.course}');
    setState(() {
      studentAttendanceDataModel = attendanceServices.getAttendance(
          faculty: widget.faculty, course: widget.course);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: studentAttendanceDataModel,
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  const LoadingWidget(),
                  Text(
                    'Loading Attendance Data',
                    style: TextStyle(fontFamily: fontFamilySans),
                  ),
                ],
              ));
            }
            present =
                snapshot.data?.present != null ? snapshot.data!.present : 0;
            totalClasses = snapshot.data?.total_classes != null
                ? snapshot.data!.total_classes
                : 0;
            absent = totalClasses.toInt() - present;
            attendancePercenetage = snapshot.data?.attendance_percentage != null
                ? snapshot.data!.attendance_percentage.round()
                : 0;
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Image(
                        image: AssetImage(
                          'assets/images/sram-logo.png',
                        ),
                        height: 50,
                        width: 100,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
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
                    height: 415,
                    width: 450,
                    child: TableCalendar(
                      firstDay: DateTime.utc(2021, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      calendarStyle: CalendarStyle(
                        todayDecoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: fontFamilySans,
                          fontWeight: FontWeight.normal,
                        ),
                        todayTextStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: fontFamilySans,
                          fontWeight: FontWeight.normal,
                        ),
                        weekendTextStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: fontFamilySans,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        todayBuilder: (context, day, focusedDay) {
                          List<StudentAttendanceDayWiseModel> attendanceData =
                              snapshot.data!.attendance;
                          Color color = Colors.blue;
                          if (attendanceData.isNotEmpty) {
                            if (attendanceData.last.date.day ==
                                    focusedDay.day &&
                                attendanceData.last.date.month ==
                                    focusedDay.month &&
                                attendanceData.last.date.year ==
                                    focusedDay.year) {
                              color = Colors.green;
                            }
                          }
                          return Container(
                            width: 40,
                            decoration: BoxDecoration(
                              color: color,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                )
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: fontFamilySans,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                        defaultBuilder: (context, day, focusedDay) {
                          if (snapshot.hasData == true) {
                            if (snapshot.data!.attendance.isNotEmpty) {
                              for (StudentAttendanceDayWiseModel attendance
                                  in snapshot.data!.attendance) {
                                if (day.day == attendance.date.day &&
                                    day.month == attendance.date.month &&
                                    day.year == attendance.date.year &&
                                    attendance.present >= 1) {
                                  return Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        )
                                      ],
                                      color: Colors.green.shade400,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontFamilySans,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (day.day == attendance.date.day &&
                                    day.month == attendance.date.month &&
                                    day.year == attendance.date.year &&
                                    attendance.present == 0) {
                                  return Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        )
                                      ],
                                      color: Colors.red.shade400,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontFamilySans,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                            return null;
                          }
                          return null;
                        },
                      ),
                      onPageChanged: (focusedDay) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AttendanceCountDisplayWidget(
                                  title: 'Present', count: present),
                              AttendanceCountDisplayWidget(
                                  title: 'Absent', count: absent),
                              AttendanceCountDisplayWidget(
                                  title: 'Total Days', count: totalClasses),
                              Stack(
                                children: [
                                  Material(
                                    color: Colors.grey.shade200,
                                    elevation: 10,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          '${attendancePercenetage.toString()}%',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontFamily: fontFamilySans,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                      bottom: 45,
                                      left: 60,
                                      child: Icon(
                                        Icons.error_outline_sharp,
                                        size: 15,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Material(
                        color: Colors.grey.shade200,
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                                RoutingConstants.faceScanScreenRouteName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.qr_code_2_outlined,
                                size: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
