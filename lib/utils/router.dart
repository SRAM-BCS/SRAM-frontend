import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter() {
 GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: ,
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ;
      },
   
    ),
  ],
);

return router;
  }
}