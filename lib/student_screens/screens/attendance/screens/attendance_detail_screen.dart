import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/student_screens/screens/attendance/widgets/attendance_count_display_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:developer' as dev;

import '../../../../constants/constants.dart';
import '../../../../constants/routing_constants.dart';

class AttendanceDetailScreen extends StatefulWidget {
  const AttendanceDetailScreen({super.key});

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(day, _selectedDay);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    todayBuilder: (context, day, focusedDay) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: fontFamilySans,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                    markerBuilder: (context, day, events) {
                      if (day == DateTime.utc(2023, 07, 10)) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
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
                    },
                  ),
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
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
        ),
      ),
    );
  }
}
