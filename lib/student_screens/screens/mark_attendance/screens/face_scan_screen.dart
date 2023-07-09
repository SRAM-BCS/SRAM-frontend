import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../constants/routing_constants.dart';
import '../../../provider/mark_attendance_provider.dart';

class FaceScanScreen extends StatefulWidget {
  const FaceScanScreen({super.key});

  @override
  State<FaceScanScreen> createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {
  bool isFaceCaptured = false;
  @override
  Widget build(BuildContext context) {
    final markAttendanceProvider =
        Provider.of<MarkAttendanceProvider>(context, listen: true);

    return Scaffold(
      body: SmartFaceCamera(
        defaultFlashMode: CameraFlashMode.auto,
        showFlashControl: false,
        showCameraLensControl: false,
        showCaptureControl: false,
        autoCapture: true,
        defaultCameraLens: CameraLens.front,
        message: markAttendanceProvider.isFaceCaptured
            ? 'Face Captured SuccessFully'
            : 'Center your face in the square',
        onCapture: (File? image) {
          markAttendanceProvider.setFaceCaptured(true);
          if (image != null) {
            markAttendanceProvider.setFaceImage(image);
          }

          GoRouter.of(context).pushReplacementNamed(
              RoutingConstants.qrCodeScannerScreenRouteName);
          markAttendanceProvider.setFaceCaptured(false);
        },
      ),
    );
  }
}
