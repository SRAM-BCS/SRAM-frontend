import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/faculty_screens/screens/attendance/widget/attendance_table_calender_widget.dart';

import 'package:summer_project/constants/routing_constants.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../../constants/constants.dart';
import '../../../../student_screens/screens/attendance/widgets/attendance_count_display_widget.dart';
import '../../../provider/faculty_attendance_data_provider.dart';
import '../../../provider/faculty_provider.dart';
import '../widget/faculty_status_code_toggle_button_widget.dart';

class FacultyAttendanceDetailScreen extends StatefulWidget {
  final String batchCode;
  final String courseCode;
  const FacultyAttendanceDetailScreen({
    Key? key,
    required this.batchCode,
    required this.courseCode,
  }) : super(key: key);

  @override
  State<FacultyAttendanceDetailScreen> createState() =>
      _FacultyAttendanceDetailScreenState();
}

class _FacultyAttendanceDetailScreenState
    extends State<FacultyAttendanceDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final facultyAttendanceDataProvider =
          Provider.of<FacultyAttendanceDataProvider>(context, listen: false);
      facultyAttendanceDataProvider.callAttendanceDataApi(
          courseCode: widget.courseCode,
          batchCode: widget.batchCode,
          context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final facultyAttendanceDataProvider =
        Provider.of<FacultyAttendanceDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: facultyAttendanceDataProvider.isLoading
            ? Center(
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
              ))
            : Column(
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
                      child: AttendanceTableCalenderWidget(
                        batchCode: widget.batchCode,
                        courseCode: widget.courseCode,
                      )),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pushNamed(
                          RoutingConstants.facultyStudentStatScreenRouteName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 1,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                              width: double.infinity,
                            ),
                            Text(
                              'View Student Attendance List',
                              style: TextStyle(
                                  fontFamily: fontFamilySans,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const FacultyStatusToggleButtonWidget()
                ],
              ),
      ),
    );
  }
}
