import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/routing_constants.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Select Role'),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  RoutingConstants.loginRouteName,
                );
              },
              child: const Text('Faculty'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(RoutingConstants.registerRouteName);
              },
              child: const Text('Student'),
            ),
          ],
        ),
      ),
    );
  }
}
