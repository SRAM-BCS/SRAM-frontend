import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/faculty_screens/services/faculty_attendance_services.dart';

import '../../../../constants/routing_constants.dart';
import '../../../../models/faculty_course_model.dart';
import '../../../../student_screens/screens/attendance/widgets/course_tile.dart';
import '../../../provider/faculty_provider.dart';

class FacultyBatchListScreen extends StatefulWidget {
  final String email;
  const FacultyBatchListScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<FacultyBatchListScreen> createState() => _FacultyBatchListScreenState();
}

class _FacultyBatchListScreenState extends State<FacultyBatchListScreen> {
  final facultyAttendanceServices = FacultyAttendanceServices();
  Future<List<FacultyCourseModel>>? courseList;
  @override
  void initState() {
    getCourse();
    super.initState();
  }

  void getCourse() {
    courseList =
        facultyAttendanceServices.facultyBatchCourse(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final facultyProvider = Provider.of<FacultyProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Course List',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamilySans),
            ),
          ),
          FutureBuilder(
            future: courseList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            RoutingConstants
                                .facultyAttendanceDetailScreenRouteName,
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                                RoutingConstants
                                    .facultyAttendanceDetailScreenRouteName,
                                queryParameters: {
                                  'courseCode':
                                      snapshot.data![index].course.code,
                                  'batchCode': snapshot.data![index].batch.code,
                                });
                          },
                          child: CourseTile(
                              courseName: snapshot.data![index].course.name,
                              courseCode: snapshot.data![index].course.code,
                              facultyName: snapshot.data![index].batch.title,
                              facultyEmail: '',
                              facultyCode: snapshot.data![index].batch.code),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text('No course Batch Data to Show');
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
