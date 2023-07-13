import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

import 'package:summer_project/auth/services/common_auth_services.dart';
import 'package:summer_project/constants/constants.dart';

import '../../constants/routing_constants.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  final String endRoute;
  const OTPScreen({
    Key? key,
    required this.email,
    required this.endRoute,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final commonAuthServices = CommonAuthServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Text(
            'Verification Code was Sent to your email',
            style: TextStyle(
                fontFamily: fontFamilySans,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          OtpTextField(
            numberOfFields: 6,
            borderColor: const Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            onSubmit: (String verificationCode) {
              commonAuthServices
                  .verifyOTP(
                      otp: int.parse(
                        verificationCode,
                      ),
                      email: widget.email)
                  .then(
                (value) {
                  if (value == 202) {
                    if (widget.endRoute ==
                        RoutingConstants.studentLoginScreenRouteName) {
                      GoRouter.of(context).pushReplacementNamed(
                          RoutingConstants.registerRouteName,
                          queryParameters: {'email': widget.email});
                    } else if (widget.endRoute ==
                        RoutingConstants.forgotPasswordResetScreenRouteName) {
                      GoRouter.of(context).pushReplacementNamed(
                          RoutingConstants.forgotPasswordResetScreenRouteName,
                          queryParameters: {'email': widget.email});
                    }
                  }
                },
              );
            },
            // end onSubmit
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'OTP expires in 3 minutes',
            style: TextStyle(
                fontFamily: fontFamilySans,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'A new OTP will be sent automatically after current OTP expires',
              style: TextStyle(
                  fontFamily: fontFamilySans,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(flex: 2, child: Container())
        ],
      ),
    );
  }
}
