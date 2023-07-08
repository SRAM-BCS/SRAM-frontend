import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:summer_project/auth/services/common_auth_services.dart';
import 'package:summer_project/auth/widgets/auth_textfield_widget.dart';

import '../../constants/routing_constants.dart';

class ForgotPasswordResetScreen extends StatefulWidget {
  final String otp;
  final String email;
  const ForgotPasswordResetScreen({
    Key? key,
    required this.otp,
    required this.email,
  }) : super(key: key);

  @override
  State<ForgotPasswordResetScreen> createState() =>
      _ForgotPasswordResetScreenState();
}

class _ForgotPasswordResetScreenState extends State<ForgotPasswordResetScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final commonAuthServices = CommonAuthServices();

  @override
  void dispose() {
    _passwordTextController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 9,
              right: MediaQuery.of(context).size.height / 20,
              left: MediaQuery.of(context).size.height / 20),
          width: double.infinity,
          child: Column(
            children: [
              const Flexible(
                flex: 2,
                child: SizedBox(),
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(child: Text('Password Reset')),
              const SizedBox(
                height: 24,
              ),
              AuthTextFieldWidget(
                  isPassword: true,
                  textEditingController: _passwordTextController,
                  hintText: 'Enter Password ',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    dev.log("Reset Password Form Validation Passed ",
                        name: "Form Validation -frontend");
                    commonAuthServices
                        .forgotPassword(
                            email: widget.email,
                            otp: widget.otp,
                            newPassword: _passwordTextController.text)
                        .then((value) {
                      if (value == 200 || value == 204 || value == 201) {
                        GoRouter.of(context)
                            .pushReplacement(RoutingConstants.loginRouteName);
                      }
                    });
                  } else {
                    dev.log("Reset Password Form Validation Failed",
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
                            child: Text("Reset Password"),
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
