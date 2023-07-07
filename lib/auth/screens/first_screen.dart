import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/routing_constants.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

enum ValidationStatus { accepted, pending, denied }

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).pushNamed(
        RoutingConstants.selectRoleScreenRouteName,
      );
    });
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
