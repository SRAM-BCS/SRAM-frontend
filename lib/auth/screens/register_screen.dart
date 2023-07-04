import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:summer_project/auth/constants.dart';
import 'package:summer_project/auth/widgets/image_pick_preview.dart';
import 'package:summer_project/common_widgets/toast.dart';
import 'dart:developer' as dev;

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
  final _studentNameTextController = TextEditingController();
  final _classRollNoTextController = TextEditingController();
  String yearJoined = '2021';
  String batch = 'BCS';

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _studentNameTextController.dispose();
    _classRollNoTextController.dispose();
  }

  // void pickImageFromGallery(
  //     bool forStudentImage, bool forStudentImageId) async {
  //   final XFile? image =
  //       await _imagePicker.pickImage(source: ImageSource.camera);

  //   if (image != null && forStudentImage) {
  //     studentImage = image;
  //   } else if (image != null && forStudentImageId) {
  //     studentIdImage = image;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = AuthTextFieldWidget(
        isEmail: true,
        prefixIcon: const Icon(Icons.email),
        textEditingController: _emailTextController,
        hintText: 'Enter Email',
        textInputType: TextInputType.emailAddress);

    final name = AuthTextFieldWidget(
        isName: true,
        prefixIcon: const Icon(Icons.person),
        textEditingController: _studentNameTextController,
        hintText: "Enter Student's Name",
        textInputType: TextInputType.name);

    final classRollNoField = Expanded(
      child: AuthTextFieldWidget(
          textEditingController: _classRollNoTextController,
          hintText: 'Enter Class Roll No.',
          textInputType: TextInputType.number),
    );

    DropdownButton<String> yearJoinedDropDown() {
      List<DropdownMenuItem<String>> dropdownItems = [];
      for (String year in yearJoinedList) {
        var newItem = DropdownMenuItem(
          value: year,
          child: Text(year),
        );
        dropdownItems.add(newItem);
      }

      return DropdownButton<String>(
        value: yearJoined,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            yearJoined = value.toString();
          });
        },
      );
    }

    DropdownButton<String> batchDropDown() {
      List<DropdownMenuItem<String>> dropdownItems = [];
      for (String batch in batchList) {
        var newItem = DropdownMenuItem(
          value: batch,
          child: Text(batch),
        );
        dropdownItems.add(newItem);
      }

      return DropdownButton<String>(
        value: batch,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            batch = value.toString();
          });
        },
      );
    }

    final rollNoWidget = Row(
      children: [yearJoinedDropDown(), batchDropDown(), classRollNoField],
    );
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
      ],
    );

    void doRegister() {
      final form = formKey.currentState;
      if (form != null) {
        if (form.validate()) {
          if (true) {
// if textfield input is error filled
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 215.0),
                    const Text("Email"),
                    const SizedBox(height: 5.0),
                    emailField,
                    const SizedBox(height: 15.0),
                    const Text("Student's Name"),
                    const SizedBox(height: 10.0),
                    name,
                    const SizedBox(height: 20.0),
                    const Text("Roll No."),
                    const SizedBox(height: 5.0),
                    rollNoWidget,
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Student's PhotoGraph"),
                        ImagePicKPreviewWidget(
                          forStudentImage: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Student's ID PhotoGraph"),
                        ImagePicKPreviewWidget(
                          forStudentIdImage: true,
                        )
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    ElevatedButton(
                      onPressed: () {
                        doRegister();
                      },
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
