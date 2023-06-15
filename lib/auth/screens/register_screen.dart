import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/common_widgets/toast.dart';

import '../widgets/auth_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  bool isTeacher = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

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

    final confirmPassword = AuthTextFieldWidget(
        prefixIcon: const Icon(Icons.lock_rounded),
        textEditingController: _confirmPasswordTextController,
        hintText: 'Confirm Password',
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
          onPressed: () {},
        ),
        TextButton(
          child: const Text("Sign in",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );

    void doRegister() {
      final form = formKey.currentState;
      if (form != null) {
        if (form.validate()) {
          if (_confirmPasswordTextController.text !=
              _passwordTextController.text) {
            showToast('Password Do not Match');
            _confirmPasswordTextController.clear();
          } else {
            form.save();
            // auth.register(_username, _password, _confirmPassword).then((response) {
            //   if (response['status']) {
            //     User user = response['data'];
            //     Provider.of<UserProvider>(context, listen: false).setUser(user);
            //     Navigator.pushReplacementNamed(context, '/dashboard');
            //   } else {
            //     Flushbar(
            //       title: "Registration Failed",
            //       message: response.toString(),
            //       duration: const Duration(seconds: 10),
            //     ).show(context);
            //   }
            // });
          }
        } else {
          showToast("Check Crendentials");
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
                  const SizedBox(height: 215.0),
                  const Text("Email"),
                  const SizedBox(height: 5.0),
                  emailField,
                  const SizedBox(height: 15.0),
                  const Text("Password"),
                  const SizedBox(height: 10.0),
                  passwordField,
                  const SizedBox(height: 15.0),
                  const Text("Confirm Password"),
                  const SizedBox(height: 10.0),
                  confirmPassword,
                  const SizedBox(height: 20.0),
                  //  auth.registeredInStatus == Status.Registering
                  //       ? loading
                  //       :
                  ElevatedButton(
                    onPressed: () {
                      doRegister();
                    },
                    child: const Text('Register'),
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
