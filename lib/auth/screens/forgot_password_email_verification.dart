import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/services/common_auth_services.dart';
import 'package:summer_project/auth/widgets/auth_textfield_widget.dart';
import 'dart:developer' as dev;

import '../../constants/routing_constants.dart';

class ForgotPasswordEmailVerificationScreen extends StatefulWidget {
  const ForgotPasswordEmailVerificationScreen({
    Key? key,
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
        queryParameters: {'email': _emailTextController.text});
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
                flex: 1,
                child: Container(),
              ),
              const Flexible(
                flex: 2,
                child: SizedBox(),
              ),
              const Center(
                child: Text(
                  'Enter Email for Verification',
                  style: TextStyle(
                    fontSize: 15,
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
              InkWell(
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
                child: Ink(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4,
                        ),
                      ),
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Center(
                            child: Text("Submit"),
                          ),
                  ),
                ),
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
