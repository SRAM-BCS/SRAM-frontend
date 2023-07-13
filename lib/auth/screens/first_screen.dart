import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as dev;
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/constants.dart';
import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/auth/preferences/student_user_preferences.dart';
import 'package:summer_project/constants/routing_constants.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final commonPreferences = CommonPreferences();
  final studentUserPreferences = StudentUserPreferences();
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    String jwt = await commonPreferences.getJwt();
    AppProgressStatus? appProgress =
        await commonPreferences.getStudentAppProgress();

    if (jwt.isNotEmpty && context.mounted) {
      dev.log('jwt = $jwt', name: 'Jwt Status');
//todo: Add condition to check whose jwt it is (faculty or student) and navigate accordingly

      GoRouter.of(context).pushNamed(RoutingConstants.sNavBarScreenRouteName);
    } else if (jwt.isEmpty) {
      if (context.mounted) {
        if (appProgress == AppProgressStatus.registered) {
          dev.log('Registered', name: 'AppProgressStatus');
          GoRouter.of(context)
              .pushReplacement(RoutingConstants.studentLoginScreenRouteName);
        }
        if (appProgress == null) {
          GoRouter.of(context)
              .pushReplacement(RoutingConstants.selectRoleScreenRouteName);
        }
      }
    } else {
      if (context.mounted) {
        dev.log('jwt Empty', name: 'Jwt Status');

        GoRouter.of(context)
            .pushReplacement(RoutingConstants.selectRoleScreenRouteName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
