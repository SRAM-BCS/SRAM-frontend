import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/screens/admin_approval_status.dart';
import 'package:summer_project/auth/screens/faculty_login_screen.dart';
import 'package:summer_project/auth/screens/first_screen.dart';
import 'package:summer_project/auth/screens/forgot_password_reset_screen.dart';
import 'package:summer_project/auth/screens/otp_screen.dart';
import 'package:summer_project/auth/screens/register_screen.dart';
import 'package:summer_project/auth/screens/student_login_screen.dart';
import 'package:summer_project/constants/routing_constants.dart';
import 'package:summer_project/faculty_screens/screens/attendance/screens/faculty_attendance_details_screen.dart';
import 'package:summer_project/faculty_screens/screens/attendance/screens/faculty_batch_list_screen.dart';
import 'package:summer_project/faculty_screens/screens/attendance/screens/faculty_student_stat_screen.dart';
import 'package:summer_project/faculty_screens/screens/f_nav_bar_screen.dart';
import 'package:summer_project/faculty_screens/screens/faculty_profile_screen.dart';
import 'package:summer_project/student_screens/screens/attendance/screens/attendance_detail_screen.dart';
import 'package:summer_project/student_screens/screens/attendance/screens/course_list.dart';
import 'package:summer_project/faculty_screens/screens/attendance/screens/faculty_student_attendance_list._screen.dart';
import 'package:summer_project/student_screens/screens/mark_attendance/screens/loading_screen.dart';

import 'package:summer_project/student_screens/screens/s_bottom_navbar_screen.dart';
import 'package:summer_project/student_screens/screens/home_screen.dart';

import '../auth/screens/forgot_password_email_verification.dart';
import '../auth/screens/select_role_screen.dart';
import '../student_screens/screens/mark_attendance/screens/face_scan_screen.dart';
import '../student_screens/screens/mark_attendance/screens/mark_attendanace_screen.dart';
import '../student_screens/screens/mark_attendance/screens/qr_code_scanner.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          name: RoutingConstants.firstScreenRouteName,
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const FirstScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.selectRoleScreenRouteName,
          path: '/selectRoleScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectRoleScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.loginRouteName,
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const FacultyLoginScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.registerRouteName,
          path: '/register',
          builder: (BuildContext context, GoRouterState state) {
            return RegisterScreen(email: state.queryParameters['email']!);
          },
        ),
        GoRoute(
          name: RoutingConstants.studentHomeScreenRouteName,
          path: '/studentHomeScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const StudentHomeScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.attendanceMarkScreenRouteName,
          path: '/attendenceMarkScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const MarkAttendanceScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.sNavBarScreenRouteName,
          path: '/sNavBarScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const SBottomNavBar();
          },
        ),
        GoRoute(
          name: RoutingConstants.qrCodeScannerScreenRouteName,
          path: '/qrcodeScannerScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const QRCodeScannerScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.faceScanScreenRouteName,
          path: '/faceScanScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const FaceScanScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.studentLoginScreenRouteName,
          path: '/studentLoginScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const StudentLoginScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.adminApprovalStatusScreenRouteName,
          path: '/adminApprovalStatusScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const AdminApprovalStatusScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.forgotPasswordResetScreenRouteName,
          path: '/forgotPasswordResetScreen',
          builder: (BuildContext context, GoRouterState state) {
            return ForgotPasswordResetScreen(
              email: state.queryParameters['email']!,
              otp: state.queryParameters['otp']!,
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.forgotPasswordEmailVerificationScreenRouteName,
          path: '/forgotPasswordEmailVerificationScreen',
          builder: (BuildContext context, GoRouterState state) {
            return ForgotPasswordEmailVerificationScreen(
              endRoute: state.queryParameters['endRoute']!,
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.otpVerifyScreenRouteName,
          path: '/otpVerifyScreen',
          builder: (BuildContext context, GoRouterState state) {
            return OTPScreen(
                email: state.queryParameters['email']!,
                endRoute: state.queryParameters['endRoute']!);
          },
        ),
        GoRoute(
          name: RoutingConstants.courseListScreenRouteName,
          path: '/courseListScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const CourseList();
          },
        ),
        GoRoute(
          name: RoutingConstants.attendanceDetailScreenRouteName,
          path: '/attendanceDetailScreen',
          builder: (BuildContext context, GoRouterState state) {
            return AttendanceDetailScreen(
              faculty: state.queryParameters['faculty']!,
              course: state.queryParameters['course']!,
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.loadingScreenRouteName,
          path: '/loadingScreen',
          builder: (BuildContext context, GoRouterState state) {
            return LoadingScreen(
              imagePath: state.queryParameters['imagePath']!,
            );
          },
        ),

        //Faculty Routes

        GoRoute(
          name: RoutingConstants.facultyLoginScreenRouteName,
          path: '/facultyLoginScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const FacultyLoginScreen();
          },
        ),

        GoRoute(
          name: RoutingConstants.fNavBarScreenRouteName,
          path: '/facultyNavBarScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const FNavBarScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.facultyProfileScreen,
          path: '/facultyProfileScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const FacultyProfileScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.facultyBatchCourseList,
          path: '/facultyBatchCourseList',
          builder: (BuildContext context, GoRouterState state) {
            return FacultyBatchListScreen(
              email: state.queryParameters['email']!,
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.facultyAttendanceDetailScreenRouteName,
          path: '/facultyAttendanceDetailScreen',
          builder: (BuildContext context, GoRouterState state) {
            return FacultyAttendanceDetailScreen(
              batchCode: state.queryParameters['batchCode']!,
              courseCode: state.queryParameters['courseCode']!,
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.facultyStudentAttendanceListScreenRouteName,
          path: '/facultyStudentAttendanceListScreen',
          builder: (BuildContext context, GoRouterState state) {
            return FacultyStudentAttendanceListScreen(
              date: state.queryParameters['date']!,
            );
          },
        ),
        GoRoute(
          name: RoutingConstants.facultyStudentStatScreenRouteName,
          path: '/facultyStudentStatScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const FacultyStudentStatScreen();
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(
            child: Scaffold(
          body: Center(
            child: Text(
              'ERROR PAGE ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ));
      },
    );

    return router;
  }
}
