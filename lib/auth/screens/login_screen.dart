import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();

  String _username = '', _password = '';

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

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
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form?.validate != null) {
        if (form!.validate()) {
          form.save();

          final Future<Map<String, dynamic>> successfulMessage =
              auth.login(_username, _password);

          successfulMessage.then((response) {
            if (response['status']) {
              User user = response['user'];
              Provider.of<UserProvider>(context, listen: false).setUser(user);
              Navigator.pushReplacementNamed(context, '/dashboard');
            } else {
              SnackBar(
                title: "Failed Login",
                message: response['message']['message'].toString(),
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          });
        } else {
          print("form is invalid");
        }
      }
    };

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
                  label("Email"),
                  const SizedBox(height: 5.0),
                  usernameField,
                  const SizedBox(height: 20.0),
                  label("Password"),
                  const SizedBox(height: 5.0),
                  passwordField,
                  const SizedBox(height: 20.0),
                  auth.loggedInStatus == Status.Authenticating
                      ? loading
                      : longButtons("Login", doLogin),
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
