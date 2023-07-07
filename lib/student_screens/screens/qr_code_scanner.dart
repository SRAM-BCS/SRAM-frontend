import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:developer' as dev;
import 'package:summer_project/constants/routing_constants.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  bool isQrCodeFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            // scanWindow: Rect.fromLTRB(
            //   MediaQuery.of(context).size.width / 10,
            //   MediaQuery.of(context).size.height / 10,
            //   MediaQuery.of(context).size.width / 10,
            //   MediaQuery.of(context).size.height / 10,
            // ),
            // fit: BoxFit.contain,

            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (Barcode barcode in barcodes) {
                dev.log(barcode.rawValue.toString(),
                    name: 'Captured Barcode Data');
              }

              if (barcodes.isNotEmpty) {
                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    GoRouter.of(context).pushReplacementNamed(
                        RoutingConstants.faceScanScreenRouteName);
                  },
                );
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
                      child: isQrCodeFound
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
