import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import 'package:summer_project/constants/routing_constants.dart';
import 'package:summer_project/student_screens/provider/mark_attendance_provider.dart';
import 'package:summer_project/student_screens/services/attendance_services.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  bool isQrCodeFound = false;
  final _attendanceServices = AttendanceServices();

  @override
  Widget build(BuildContext context) {
    final markAttendanceProvider =
        Provider.of<MarkAttendanceProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            startDelay: true,
            controller: MobileScannerController(
              detectionTimeoutMs: 500,
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
            onDetect: (capture) {
              dev.log('QR Code Detected', name: 'QR Code Scanner');
              final List<Barcode> barcodes = capture.barcodes;
              for (Barcode barcode in barcodes) {
                dev.log(barcode.rawValue.toString(),
                    name: 'Captured Barcode Data');
              }

              if (barcodes.isNotEmpty) {
                markAttendanceProvider.setQrCodeScanned(true);
                if (barcodes[0].rawValue.toString().isNotEmpty) {
                  markAttendanceProvider
                      .setQrCode(barcodes[0].rawValue.toString());

                  GoRouter.of(context).pushReplacementNamed(
                      RoutingConstants.sNavBarScreenRouteName);
                  markAttendanceProvider.setQrCodeScanned(false);
                  _attendanceServices.markAttendance(
                      coursecode: markAttendanceProvider.courseCode,
                      classRoom: markAttendanceProvider.qrcode,
                      teachercode: markAttendanceProvider.teacherCode);
                }
              }
            },
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.width / 10,
            bottom: MediaQuery.of(context).size.width / 10,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Scanning Qr Code'),
                    const SizedBox(
                      width: 10,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      child: markAttendanceProvider.isQrCodeScanned
                          ? Icon(
                              Icons.done_rounded,
                              size: 30,
                              color: Colors.green.shade300,
                            )
                          : const CircularProgressIndicator(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
