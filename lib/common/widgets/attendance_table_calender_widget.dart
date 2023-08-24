import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/constants.dart';
import '../../constants/routing_constants.dart';
import '../../faculty_screens/models/attendance_day_wise.dart';
import '../../faculty_screens/provider/faculty_attendance_data_provider.dart';
import '../../faculty_screens/services/faculty_attendance_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AttendanceTableCalenderWidget extends StatefulWidget {
  final String batchCode;
  final String courseCode;
  const AttendanceTableCalenderWidget({
    Key? key,
    required this.batchCode,
    required this.courseCode,
  }) : super(key: key);

  @override
  State<AttendanceTableCalenderWidget> createState() =>
      _AttendanceTableCalenderWidgetState();
}

class _AttendanceTableCalenderWidgetState
    extends State<AttendanceTableCalenderWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final facultyAttendanceService = FacultyAttendanceServices();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Consumer<FacultyAttendanceDataProvider>(
        builder: (context, value, child) {
          if (value.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return TableCalendar(
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
                defaultBuilder: (context, day, focusedDay) {
                  if (value.facultyAttendanceDetailModel != null) {
                    for (AttendanceDayWise d in value.attendanceDaywiseList) {
                      if (day.day == d.date.day &&
                          day.month == d.date.month &&
                          day.year == d.date.year) {
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                                RoutingConstants
                                    .facultyStudentAttendanceListScreenRouteName,
                                queryParameters: {
                                  'date': DateFormat('dd-MMM-yyyy').format(day),
                                });
                          },
                          child: Container(
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
                          ),
                        );
                      }
                    }
                  }
                  return null;
                },
              ),
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            );
          }
        },
      ),
    );
  }
}
