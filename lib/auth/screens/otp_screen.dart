import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

import 'package:summer_project/auth/services/common_auth_services.dart';

import '../../constants/routing_constants.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final commonAuthServices = CommonAuthServices();

  @override
  void initState() {
    generateOTP();
    super.initState();
  }

  void generateOTP() async {
    int statusCode = await commonAuthServices.generateOTP(email: widget.email);
    dev.log(statusCode.toString(), name: 'OTP Generate Status Code');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          const Text('Verification Code was Sent to your email'),
          const SizedBox(
            height: 24,
          ),
          OtpTextField(
            numberOfFields: 6,
            borderColor: const Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,

            onSubmit: (String verificationCode) {
              commonAuthServices.verifyOTP(int.parse(verificationCode)).then(
                (value) {
                  if (value == 200) {
                    dev.log('OTP Verified', name: 'OTP Verification');
                  }
                  GoRouter.of(context).pushReplacement(
                    RoutingConstants.forgotPasswordResetScreenRouteName,
                  );
                },
              );
            },
            // end onSubmit
          ),
          Flexible(flex: 2, child: Container())
        ],
      ),
    );
  }
}
