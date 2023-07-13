import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as dev;
import 'package:summer_project/auth/services/common_auth_services.dart';
import 'package:summer_project/auth/widgets/auth_textfield_widget.dart';
import 'package:summer_project/auth/widgets/button_widget_1.dart';
import 'package:summer_project/constants/constants.dart';

import '../../constants/routing_constants.dart';
import '../widgets/form_widgets.dart';

class ForgotPasswordEmailVerificationScreen extends StatefulWidget {
  final String endRoute;
  const ForgotPasswordEmailVerificationScreen({
    Key? key,
    required this.endRoute,
  }) : super(key: key);

  @override
  State<ForgotPasswordEmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<ForgotPasswordEmailVerificationScreen> {
  final commonAuthServices = CommonAuthServices();
  final TextEditingController _emailTextController = TextEditingController();
  final bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  void navigateToOtpScreen() {
    commonAuthServices.generateOTP(email: _emailTextController.text);
    GoRouter.of(context).pushNamed(RoutingConstants.otpVerifyScreenRouteName,
        queryParameters: {
          'email': _emailTextController.text,
          'endRoute': widget.endRoute
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(),
              ),
              const Flexible(
                flex: 2,
                child: SizedBox(),
              ),
              Center(
                child: Text(
                  'Enter Email for Verification',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: fontFamilySans,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              AuthTextFieldWidget(
                  isEmail: true,
                  textEditingController: _emailTextController,
                  hintText: 'Enter Email ',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              ButtonWidget1(
                title: 'Submit',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    dev.log("SignUp Form Validation Passed ",
                        name: "Form Validation -frontend");
                    navigateToOtpScreen();
                  } else {
                    dev.log("SignUp Form Validation Failed",
                        name: "Form Validation -frontend");
                  }
                },
                isLoading: _isLoading,
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  headerText(title: "Already have an account?"),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                          RoutingConstants.studentLoginScreenRouteName);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: fontFamilySans,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
