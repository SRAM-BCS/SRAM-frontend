import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:summer_project/auth/constants.dart';
import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/auth/widgets/button_widget_1.dart';
import 'package:summer_project/auth/widgets/image_preview.dart';
import 'package:summer_project/common/widgets/toast.dart';
import 'package:summer_project/constants/constants.dart';
import 'dart:developer' as dev;

import '../../constants/routing_constants.dart';
import '../preferences/student_user_preferences.dart';
import '../services/student_auth_services.dart';
import '../widgets/auth_textfield_widget.dart';
import '../widgets/form_widgets.dart';

class RegisterScreen extends StatefulWidget {
  final String email;
  const RegisterScreen({super.key, required this.email});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final studentPreference = StudentUserPreferences();
  final commonPreferences = CommonPreferences();
  final formKey = GlobalKey<FormState>();
  bool showLoader = false;
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
                email: widget.email,
                password: _confirmPasswordTextController.text,
                name: _studentNameTextController.text,
                rollNo: '$yearJoined$batch-${_classRollNoTextController.text}',
                batch: '$yearJoined$batch',
                studentImagePath: studentImagePath,
                studentIdImagePath: studentIdImagePath)
            .then((value) {
          if (value == 201) {
            setState(() {
              showLoader = false;
            });
            commonPreferences
                .setStudentAppProgress(AppProgressStatus.registered);
            GoRouter.of(context)
                .pushNamed(RoutingConstants.studentLoginScreenRouteName);
          } else {
            setState(() {
              showLoader = false;
            });
          }
        });
      } else {
        showToast(msg: 'Registration Failed');
      }
    }
  }

  void pickImage(
      {required bool fromCamera, required bool forStudentImage}) async {
    final XFile? image = await _imagePicker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);

    if (image != null && fromCamera) {
      imagePathFromCamera = image.path;
    } else if (image != null && !fromCamera) {
      imagePathFromGallery = image.path;
    } else {
      dev.log('Image is null', name: 'ImagePicker');
    }

    if (forStudentImage) {
      setState(() {
        studentImagePath =
            fromCamera ? imagePathFromCamera : imagePathFromGallery;
      });

      dev.log(studentImagePath, name: 'Student Image Path');
    } else if (forStudentImage == false) {
      setState(() {
        studentIdImagePath =
            fromCamera ? imagePathFromCamera : imagePathFromGallery;
      });
      dev.log(studentIdImagePath, name: 'Student ID Image Path');
    }

    dev.log(studentIdImagePath, name: 'id path');
    dev.log(studentImagePath, name: 'image path');
    dev.log(fromCamera.toString(), name: 'isCamera');
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Text(
        widget.email,
        style: TextStyle(fontSize: 18, fontFamily: fontFamilySans),
      ),
    );

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
          child: Text(year, style: TextStyle(fontFamily: fontFamilySans)),
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
          child: Text(batch, style: TextStyle(fontFamily: fontFamilySans)),
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

    Widget imagePickWidget({required bool forStudentImage}) => Row(
          children: [
            IconButton(
              onPressed: () {
                pickImage(fromCamera: true, forStudentImage: forStudentImage);
              },
              icon: const Icon(Icons.camera_alt_rounded),
            ),
            IconButton(
              onPressed: () {
                pickImage(fromCamera: false, forStudentImage: forStudentImage);
              },
              icon: const Icon(Icons.upload),
            ),
            ImagePreviewWidget(
                imagePath:
                    forStudentImage ? studentImagePath : studentIdImagePath)
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
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Student Register Screen',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: fontFamilySans,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    headerText(title: 'Email'),
                    const SizedBox(height: 5.0),
                    emailField,
                    const SizedBox(height: 15.0),
                    headerText(title: "Student's Full Name"),
                    const SizedBox(height: 10.0),
                    name,
                    const SizedBox(height: 20.0),
                    headerText(title: 'Roll No.'),
                    const SizedBox(height: 5.0),
                    rollNoWidget,
                    const SizedBox(height: 15.0),
                    headerText(title: 'Password'),
                    const SizedBox(height: 5.0),
                    passwordField,
                    const SizedBox(height: 15.0),
                    headerText(title: 'Confirm Password'),
                    const SizedBox(height: 5.0),
                    confirmPasswordField,
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headerText(title: "Student's Image"),
                        imagePickWidget(forStudentImage: true)
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headerText(title: "Student's ID Image"),
                        imagePickWidget(forStudentImage: false)
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    ButtonWidget1(
                      title: "Register",
                      onTap: register,
                      isLoading: showLoader,
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        headerText(title: "Already have an account?"),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                                RoutingConstants.studentLoginScreenRouteName);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: fontFamilySans,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
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
