import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/constants/routing_constants.dart';
import 'package:summer_project/models/student_course_model.dart';
import 'package:summer_project/student_screens/screens/attendance/widgets/course_tile.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../provider/mark_attendance_provider.dart';
import '../../../services/course_services.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final courseService = CourseServices();
  Future<List<StudentCourse>>? courseList;
  @override
  void initState() {
    getCourse();
    super.initState();
  }

  void getCourse() {
    setState(() {
      courseList = courseService.getCourse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final markAttendanceProvider =
        Provider.of<MarkAttendanceProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Course Attendance',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamilySans),
              ),
            ),
            FutureBuilder<List<StudentCourse>>(
              future: courseList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const LoadingWidget(),
                        Text(
                          'Loading Course List',
                          style: TextStyle(fontFamily: fontFamilySans),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            markAttendanceProvider.setCourseCode(
                                snapshot.data![index].courseModel.code);
                            markAttendanceProvider.setTeacherCode(
                                snapshot.data![index].facultyUserModel.code);

                            GoRouter.of(context).pushNamed(
                              RoutingConstants.attendanceDetailScreenRouteName,
                            );
                          },
                          child: CourseTile(
                            courseName: snapshot.data![index].courseModel.name,
                            courseCode: snapshot.data![index].courseModel.code,
                            facultyName:
                                snapshot.data![index].facultyUserModel.name,
                            facultyEmail:
                                snapshot.data![index].facultyUserModel.email,
                            facultyCode:
                                snapshot.data![index].facultyUserModel.code,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
