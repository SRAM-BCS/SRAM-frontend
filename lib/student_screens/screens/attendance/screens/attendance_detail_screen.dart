import 'package:flutter/material.dart';
import 'package:summer_project/student_screens/screens/attendance/widgets/attendance_count_display_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../constants/constants.dart';

class AttendanceDetailScreen extends StatefulWidget {
  const AttendanceDetailScreen({super.key});

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 415,
                width: 450,
                child: TableCalendar(
                  firstDay: DateTime.utc(2021, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: Colors.grey,
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
                              title: 'Present', count: 10),
                          AttendanceCountDisplayWidget(
                              title: 'Absent', count: 10),
                          AttendanceCountDisplayWidget(
                              title: 'Total Days', count: 10),
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
                                      '10%',
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
            )
          ],
        ),
      ),
    );
  }
}