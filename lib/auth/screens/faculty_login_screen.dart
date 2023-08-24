import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/widgets/auth_textfield_widget.dart';
import 'package:summer_project/auth/widgets/button_widget_1.dart';
import 'dart:developer' as dev;

import '../../constants/constants.dart';
import '../../constants/routing_constants.dart';
import '../services/faculty_auth_services.dart';

class FacultyLoginScreen extends StatefulWidget {
  const FacultyLoginScreen({super.key});

  @override
  State<FacultyLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<FacultyLoginScreen> {
  final facultyAuthServices = FacultyAuthServices();
  final formKey = GlobalKey<FormState>();
  bool isTeacher = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = AuthTextFieldWidget(
        prefixIcon: const Icon(Icons.email),
        textEditingController: _emailTextController,
        hintText: 'Enter Email',
        textInputType: TextInputType.emailAddress);

    final passwordField = AuthTextFieldWidget(
        prefixIcon: const Icon(Icons.lock_rounded),
        textEditingController: _passwordTextController,
        hintText: 'Enter Password',
        textInputType: TextInputType.visiblePassword);

    var loading = const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: const Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            GoRouter.of(context).pushNamed(
                RoutingConstants.forgotPasswordEmailVerificationScreenRouteName,
                queryParameters: {
                  'endRoute':
                      RoutingConstants.forgotPasswordResetScreenRouteName
                });
          },
        ),
      ],
    );

    void doLogin() {
      final form = formKey.currentState;
      dev.log('button Pressed');
      if (form != null) {
        if (form.validate()) {
          form.save();
          facultyAuthServices
              .login(
                  email: _emailTextController.text,
                  password: _passwordTextController.text)
              .then((value) {
            if (value == 200) {
              GoRouter.of(context).pushReplacementNamed(
                  RoutingConstants.fNavBarScreenRouteName);
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
                    'Faculty Login Screen',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: fontFamilySans,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Email"),
                  const SizedBox(height: 5.0),
                  emailField,
                  const SizedBox(height: 20.0),
                  const Text("Password"),
                  const SizedBox(height: 5.0),
                  passwordField,
                  const SizedBox(height: 20.0),
                  //  auth.loggedInStatus == Status.Authenticating
                  //     ? loading
                  //     :
                  ButtonWidget1(
                    title: 'SUBMIT',
                    onTap: () {
                      doLogin();
                    },
                  ),
                  const SizedBox(height: 5.0),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
