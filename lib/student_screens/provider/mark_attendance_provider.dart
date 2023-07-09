import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class MarkAttendanceProvider extends ChangeNotifier {
  //face scan
  File? _faceImage;
  File? get faceImage => _faceImage;
  bool _isFaceCaptured = false;
  bool get isFaceCaptured => _isFaceCaptured;

  void setFaceCaptured(bool isFaceCaptured) {
    _isFaceCaptured = isFaceCaptured;
    notifyListeners();
  }

  void setFaceImage(File image) {
    _faceImage = image;
    dev.log(image.toString(), name: 'Face Image');
    notifyListeners();
  }

  //qrcode
  String _qrcode = '';
  bool _isQrCodeScanned = false;
  String get qrcode => _qrcode;
  bool get isQrCodeScanned => _isQrCodeScanned;

  void setQrCodeScanned(bool isQrCodeScanned) {
    _isQrCodeScanned = isQrCodeScanned;
    notifyListeners();
  }

  void setQrCode(String qrCode) {
    _qrcode = qrCode;
    dev.log(qrCode, name: 'QR Code');
    notifyListeners();
  }
}
