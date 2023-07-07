import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:summer_project/auth/constants.dart';
import 'package:summer_project/auth/widgets/image_preview.dart';
import 'package:summer_project/common_widgets/toast.dart';
import 'dart:developer' as dev;

import '../../constants/routing_constants.dart';
import '../preferences/student_user_preferences.dart';
import '../services/student_auth_services.dart';
import '../widgets/auth_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool showLoader = false;
  final _emailTextController = TextEditingController();
  final _studentNameTextController = TextEditingController();
  final _classRollNoTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  String yearJoined = '2021';
  String batch = 'BCS';
  String studentImagePath = '';
  String studentIdImagePath = '';

  final studentAuthServices = StudentAuthServices();
  final studentUserPreferences = StudentUserPreferences();
  final _imagePicker = ImagePicker();

  String imagePathFromCamera = '';
  String imagePathFromGallery = '';

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _studentNameTextController.dispose();
    _classRollNoTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
  }

  void register() {
    setState(() {
      showLoader = true;
    });
    final form = formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        studentAuthServices
            .register(
                email: _emailTextController.text,
                password: _confirmPasswordTextController.text,
                name: _studentNameTextController.text,
                rollNo: _classRollNoTextController.text,
                batch: batch,
                studentImagePath: studentImagePath,
                studentIdImagePath: studentIdImagePath)
            .then((value) {
          if (value == 201) {
            setState(() {
              showLoader = false;
            });
            showToast(msg: 'Registration Request Sent');
            studentUserPreferences.setAdminApprovalStatus(
                status: AdminApprovalStatus.pending);
            GoRouter.of(context)
                .pushNamed(RoutingConstants.adminApprovalStatusScreenRouteName);
          }

          GoRouter.of(context)
              .pushNamed(RoutingConstants.studentLoginScreenRouteName);
        });
      } else {
        showToast(msg: 'Registration Failed');
      }
    }
  }

  void pickImage(bool fromCamera) async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null && fromCamera) {
      imagePathFromCamera = image.path;
    } else if (image != null && !fromCamera) {
      imagePathFromGallery = image.path;
    } else {
      dev.log('Image is null', name: 'ImagePicker');
    }
  }

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

    final passwordField = AuthTextFieldWidget(
        isPassword: true,
        prefixIcon: const Icon(Icons.lock),
        textEditingController: _passwordTextController,
        hintText: 'Enter Password',
        textInputType: TextInputType.visiblePassword);

    final confirmPasswordField = AuthTextFieldWidget(
        isPassword: true,
        prefixIcon: const Icon(Icons.lock),
        textEditingController: _confirmPasswordTextController,
        hintText: 'Confirm Password',
        textInputType: TextInputType.visiblePassword);

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

    Widget imagePickWidget(bool forStudentImage) => Row(
          children: [
            IconButton(
              onPressed: () {
                pickImage(true);
                if (forStudentImage) {
                  studentImagePath = imagePathFromCamera;
                } else {
                  studentIdImagePath = imagePathFromCamera;
                }
              },
              icon: const Icon(Icons.camera_alt_rounded),
            ),
            IconButton(
              onPressed: () {
                pickImage(false);
                if (forStudentImage) {
                  studentImagePath = imagePathFromGallery;
                } else {
                  studentIdImagePath = imagePathFromGallery;
                }
              },
              icon: const Icon(Icons.upload),
            ),
            ImagePreviewWidget(
                imagePath: imagePathFromCamera.isNotEmpty
                    ? imagePathFromCamera
                    : imagePathFromGallery)
          ],
        );

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
                    const Text("Password"),
                    const SizedBox(height: 5.0),
                    passwordField,
                    const SizedBox(height: 15.0),
                    const Text("Confirm Password"),
                    const SizedBox(height: 5.0),
                    confirmPasswordField,
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Student's PhotoGraph"),
                        imagePickWidget(true)
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Student's ID PhotoGraph"),
                        imagePickWidget(false)
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: showLoader
                            ? const CircularProgressIndicator()
                            : const Text('Register'),
                      ),
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
