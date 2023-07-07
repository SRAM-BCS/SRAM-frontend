import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/routing_constants.dart';

class FaceScanScreen extends StatefulWidget {
  const FaceScanScreen({super.key});

  @override
  State<FaceScanScreen> createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {
  bool isFaceCaptured = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartFaceCamera(
        defaultFlashMode: CameraFlashMode.auto,
        showFlashControl: false,
        showCameraLensControl: false,
        showCaptureControl: false,
        autoCapture: true,
        defaultCameraLens: CameraLens.front,
        message: isFaceCaptured
            ? 'Face Captured SuccessFully'
            : 'Center your face in the square',
        onCapture: (File? image) {
          Future.delayed(
            const Duration(seconds: 1),
            () {
              GoRouter.of(context).pushReplacementNamed(
                  RoutingConstants.attendanceMarkScreenRouteName);
            },
          );
        },
      ),
    );
  }
}
