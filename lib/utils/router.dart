import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/auth/screens/login_screen.dart';
import 'package:summer_project/auth/screens/register_screen.dart';
import 'package:summer_project/constants/routing_constants.dart';

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
      ],
    );

    return router;
  }
}
