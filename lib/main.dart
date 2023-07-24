import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:summer_project/student_screens/provider/mark_attendance_provider.dart';
import 'package:summer_project/student_screens/provider/student_user_provider.dart';
import 'package:summer_project/utils/router.dart';
import 'package:provider/provider.dart';

import 'faculty_screens/provider/faculty_attendance_data_provider.dart';
import 'faculty_screens/provider/faculty_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await FaceCamera.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MarkAttendanceProvider()),
    ChangeNotifierProvider(create: (context) => StudentUserProvider()),
    ChangeNotifierProvider(create: (context) => FacultyProvider()),
    ChangeNotifierProvider(
        create: (context) => FacultyAttendanceDataProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.returnRouter(),
    );
  }
}
