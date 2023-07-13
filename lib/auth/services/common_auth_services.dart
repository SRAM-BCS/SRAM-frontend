import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:summer_project/common/widgets/toast.dart';
import 'package:summer_project/utils/http_response_handle.dart';

import '../../utils/app_url.dart';
import '../preferences/common_preferences.dart';

class CommonAuthServices {
  final _commonPreference = CommonPreferences();
  Future<int> generateOTP({required String email}) async {
    int statusCode = 0;
    try {
      dev.log(email, name: "Email");
      final response = await http.post(
        Uri.parse(AppUrl.otpGenerate),
        body: jsonEncode({
          'email': email,
        }),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      httpResponseHandle(
          onSuccessMsg: 'OTP Generated',
          onSuccessMsgTag: 'CommonAuth-Generate OTP',
          response: response,
          onSuccess: () {
            statusCode = response.statusCode;
            showToast(msg: 'OTP Generated');
          });
    } catch (e) {
      dev.log(e.toString(), name: "OTP Generate Error");
    }
    return statusCode;
  }

  Future<int> verifyOTP({required int otp, required String email}) async {
    int statusCode = 0;
    try {
      final response = await http.post(Uri.parse(AppUrl.otpVerify),
          body: jsonEncode(
            {'otp': otp, 'email': email},
          ),
          headers: {"Content-Type": "application/json; charset=utf-8"});
      httpResponseHandle(
          onSuccessMsg: 'OTP Verified',
          onSuccessMsgTag: 'CommonAuth-Verify OTP',
          response: response,
          onSuccess: () {
            statusCode = response.statusCode;
            dev.log('OTP Verified', name: 'OTP Verification');
            showToast(msg: 'OTP Verified');
          });
    } catch (e) {
      dev.log(e.toString(), name: "OTP Generate Error");
    }
    return statusCode;
  }

  Future<int> forgotPassword(
      {required String email,
      required String otp,
      required String newPassword}) async {
    int statusCode = 0;
    try {
      var jwt = await _commonPreference.getJwt();
      dev.log(jwt, name: "Reading JWT");
      Map<String, String> header = {
        "Content-Type": "application/json; charset=utf-8",
        'Authorization': jwt
      };
      final response = await http.put(Uri.parse(AppUrl.forgotPassword),
          body: jsonEncode(
            {'email': email, 'otp': otp, 'newPassword': newPassword},
          ),
          headers: header);

      httpResponseHandle(
          onSuccessMsgTag: 'CommonAuth - ForgotPassword',
          onSuccessMsg: 'Password Changed Successfully',
          response: response,
          onSuccess: () {
            showToast(msg: 'Password Changed Successfully');
            statusCode = response.statusCode;
          });
    } catch (e) {
      dev.log(e.toString(), name: "Forgot Password Error");
    }
    return statusCode;
  }
}
