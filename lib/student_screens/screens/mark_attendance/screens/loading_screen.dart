import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/common/widgets/loading_widget.dart';
import 'package:summer_project/constants/constants.dart';
import 'dart:developer' as dev;

import '../../../../common/widgets/toast.dart';
import '../../../../constants/routing_constants.dart';
import '../../../provider/mark_attendance_provider.dart';
import '../../../services/attendance_services.dart';

class LoadingScreen extends StatefulWidget {
  final String imagePath;
  const LoadingScreen({super.key, required this.imagePath});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final attendanceServices = AttendanceServices();
  @override
  void initState() {
    faceVerify();
    super.initState();
  }

  void faceVerify() async {
    if (widget.imagePath.isNotEmpty) {
      attendanceServices
          .faceVerification(
        imagePath: widget.imagePath,
      )
          .then((value) {
        if (value == 200) {
          showToast(msg: 'Face Verified SuccessFully');
          GoRouter.of(context).pushReplacementNamed(
              RoutingConstants.qrCodeScannerScreenRouteName);
        } else {
          showToast(msg: 'Face Verification Failed');
          GoRouter.of(context).pop();
        }
      });
    } else {
      showToast(msg: 'Face Capture Failed');
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verifying Face...',
                style: TextStyle(fontFamily: fontFamilySans)),
            Text('Stay on this Page...',
                style: TextStyle(fontFamily: fontFamilySans)),
            const SizedBox(
              height: 20,
            ),
            const LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
