import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/auth/widgets/auth_textfield_widget.dart';
import 'dart:developer' as dev;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
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
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        TextButton(
          child: const Text("Sign up",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {},
        ),
      ],
    );

    void doLogin() {
      final form = formKey.currentState;

      if (form != null) {
        if (form.validate()) {
          form.save();

          // final Future<Map<String, dynamic>> successfulMessage =
          //     // auth.login(_username, _password);

          //     successfulMessage.then((response) {
          //   if (response['status']) {
          //     User user = response['user'];
          //     Provider.of<UserProvider>(context, listen: false).setUser(user);
          //     Navigator.pushReplacementNamed(context, '/dashboard');
          //   } else {
          //     SnackBar(
          //       title: "Failed Login",
          //       message: response['message']['message'].toString(),
          //       duration: const Duration(seconds: 3),
          //     ).show(context);
          //   }
          // });
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
                      doLogin();
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
