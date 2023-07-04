import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/screens/login_screen.dart';
import 'package:summer_project/auth/screens/register_screen.dart';
import 'package:summer_project/constants/routing_constants.dart';
import 'package:summer_project/student_screens/screens/s_bottom_navbar_screen.dart';
import 'package:summer_project/student_screens/screens/home_screen.dart';

class AppRouter {
  static GoRouter returnRouter() {
    GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          name: RoutingConstants.loginRouteName,
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.registerUsRouteName,
          path: '/register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterScreen();
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
            return const LoginScreen();
          },
        ),
        GoRoute(
          name: RoutingConstants.sNavBarScreenRouteName,
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SBottomNavBar();
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(
            child: Scaffold(
          body: Text(
            'ERROR PAGE ',
            style: TextStyle(color: Colors.white),
          ),
        ));
      },
    );

    return router;
  }
}
