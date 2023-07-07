import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:summer_project/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize();

  runApp(const MyApp());
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
