import 'package:flutter/material.dart';
import 'package:summer_project/student_screens/constants.dart';

import '../../../../constants/constants.dart';

class FacultyStudentAttendanceListScreen extends StatefulWidget {
  const FacultyStudentAttendanceListScreen({super.key});

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
              height: 150,
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
                      'Student Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamilySans,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Roll No',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamilySans,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Present/Absent',
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
              child: AnimatedList(
                  shrinkWrap: true,
                  initialItemCount: studentPresentStatus.length,
                  itemBuilder: (context, index, animation) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
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
                              studentPresentStatus[index].studentName,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: fontFamilySans,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              studentPresentStatus[index].roll,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: fontFamilySans,
                                fontSize: 17,
                              ),
                            ),
                            Card(
                                color: studentPresentStatus[index].present
                                    ? Colors.green
                                    : Colors.red,
                                child: const SizedBox(
                                  height: 20,
                                  width: 20,
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
