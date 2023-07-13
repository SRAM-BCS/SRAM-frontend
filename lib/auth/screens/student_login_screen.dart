import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/widgets/auth_textfield_widget.dart';
import 'package:summer_project/auth/widgets/button_widget_1.dart';
import 'package:summer_project/auth/widgets/form_widgets.dart';
import 'package:summer_project/constants/constants.dart';
import 'package:summer_project/constants/routing_constants.dart';
import 'dart:developer' as dev;

import '../../common/widgets/toast.dart';
import '../services/student_auth_services.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<StudentLoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isTeacher = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final studentAuthServices = StudentAuthServices();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = AuthTextFieldWidget(
        isEmail: true,
        prefixIcon: const Icon(Icons.email),
        textEditingController: _emailTextController,
        hintText: 'Enter Email',
        textInputType: TextInputType.emailAddress);

    final passwordField = AuthTextFieldWidget(
        isPassword: true,
        prefixIcon: const Icon(Icons.lock_rounded),
        textEditingController: _passwordTextController,
        hintText: 'Enter Password',
        textInputType: TextInputType.visiblePassword);

    final forgotLabel = TextButton(
      child: Text(
        "Forgot password?",
        style:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamilySans),
      ),
      onPressed: () {
        GoRouter.of(context).pushNamed(
            RoutingConstants.forgotPasswordEmailVerificationScreenRouteName,
            queryParameters: {
              'endRoute': RoutingConstants.forgotPasswordResetScreenRouteName
            });
      },
    );

    Widget bottomButtons(
            {required String title,
            required String buttonTitle,
            required VoidCallback onPressed}) =>
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: fontFamilySans,
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            GestureDetector(
              onTap: onPressed,
              child: Text(
                buttonTitle,
                style:
                    TextStyle(color: Colors.blue, fontFamily: fontFamilySans),
              ),
            ),
          ],
        );

    void login() {
      final form = formKey.currentState;

      if (form != null) {
        if (form.validate()) {
          form.save();
          setState(() {
            isLoading = true;
          });
          studentAuthServices
              .login(
                  email: _emailTextController.text,
                  password: _passwordTextController.text)
              .then((value) {
            setState(() {
              isLoading = false;
            });
            if (value == 200) {
              GoRouter.of(context).pushNamed(
                RoutingConstants.sNavBarScreenRouteName,
              );
            }
          });
        } else {
          dev.log("Form is invalid");
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150.0),
                  Text(
                    'Student Login Screen',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: fontFamilySans,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  headerText(title: "Email"),
                  const SizedBox(height: 5.0),
                  emailField,
                  const SizedBox(height: 20.0),
                  headerText(title: "Password"),
                  const SizedBox(height: 5.0),
                  passwordField,
                  const SizedBox(height: 20.0),
                  //  auth.loggedInStatus == Status.Authenticating
                  //     ? loading
                  //     :
                  ButtonWidget1(
                    title: 'Login',
                    onTap: login,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 5.0),
                  forgotLabel,
                  bottomButtons(
                    title: 'Create New User',
                    buttonTitle: 'Register',
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                        RoutingConstants
                            .forgotPasswordEmailVerificationScreenRouteName,
                        queryParameters: {
                          'endRoute':
                              RoutingConstants.studentLoginScreenRouteName
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  bottomButtons(
                    title: 'Select Another Role?',
                    buttonTitle: 'Role',
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                          RoutingConstants.selectRoleScreenRouteName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
