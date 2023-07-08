import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/widgets/auth_textfield_widget.dart';
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
          child: const Text(
            "Forgot password?",
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
      ],
    );

    void login() {
      final form = formKey.currentState;

      if (form != null) {
        if (form.validate()) {
          form.save();

          studentAuthServices
              .login(
                  email: _emailTextController.text,
                  password: _passwordTextController.text)
              .then((value) {
            if (value == 200) {
              showToast(msg: "Login Successfull");
              GoRouter.of(context)
                  .pushReplacement(RoutingConstants.sNavBarScreenRouteName);
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
                  const SizedBox(height: 250.0),
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
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: const Text('Login'),
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
