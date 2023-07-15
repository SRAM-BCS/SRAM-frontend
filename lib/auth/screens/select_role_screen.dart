import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/constants.dart';
import 'package:summer_project/auth/preferences/common_preferences.dart';
import 'package:summer_project/auth/widgets/button_widget_1.dart';

import 'package:summer_project/constants/constants.dart';

import '../../constants/routing_constants.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final commonPreference = CommonPreferences();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Role',
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: fontFamilySans,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget1(
              title: 'Faculty',
              onTap: () async {
                commonPreference
                    .setCurrentLoggedInUserLevel(CurrentUserLevel.faculty);
                GoRouter.of(context)
                    .pushNamed(RoutingConstants.facultyLoginScreenRouteName);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonWidget1(
              title: 'Student',
              onTap: () {
                commonPreference
                    .setCurrentLoggedInUserLevel(CurrentUserLevel.student);
                GoRouter.of(context).pushNamed(
                    RoutingConstants
                        .forgotPasswordEmailVerificationScreenRouteName,
                    queryParameters: {
                      'endRoute': RoutingConstants.studentLoginScreenRouteName
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
