import 'package:flutter/material.dart';
import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/models/student_course_model.dart';
import 'package:summer_project/student_screens/screens/attendance/widgets/course_tile.dart';

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
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CourseTile(
                          courseName: snapshot.data![index].courseModel.name,
                          courseCode: snapshot.data![index].courseModel.code,
                          facultyName:
                              snapshot.data![index].facultyUserModel.name,
                          facultyEmail:
                              snapshot.data![index].facultyUserModel.email,
                          facultyCode:
                              snapshot.data![index].facultyUserModel.code,
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
