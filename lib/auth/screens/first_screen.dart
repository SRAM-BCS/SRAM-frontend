import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:summer_project/constants/routing_constants.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    var jwt = await _storage.read(key: 'jwt');
    if (jwt != null && context.mounted) {
//todo: Add condition to check whose jwt it is (faculty or student) and navigate accordingly

      GoRouter.of(context).pushNamed(RoutingConstants.sNavBarScreenRouteName);
    } else {
      if (context.mounted) {
        GoRouter.of(context)
            .pushNamed(RoutingConstants.selectRoleScreenRouteName);
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
