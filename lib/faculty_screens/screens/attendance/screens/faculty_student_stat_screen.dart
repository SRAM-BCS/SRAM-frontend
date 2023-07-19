import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class FacultyStudentStatScreen extends StatelessWidget {
  const FacultyStudentStatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
        ],
      ),
    );
  }
}
