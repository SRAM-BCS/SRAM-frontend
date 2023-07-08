import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:summer_project/student_screens/provider/mark_attendance_provider.dart';
import 'package:summer_project/utils/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MarkAttendanceProvider()),
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
