import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:summer_project/constants/routing_constants.dart';

class CicularRippleButton extends StatelessWidget {
  const CicularRippleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RippleAnimation(
      color: Colors.blue.shade500,
      delay: const Duration(milliseconds: 500),
      repeat: true,
      minRadius: 100,
      ripplesCount: 6,
      duration: const Duration(seconds: 3),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(130)),
        elevation: 5,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(130)),
          onTap: () {
            GoRouter.of(context)
                .pushNamed(RoutingConstants.qrCodeScannerScreenRouteName);
          },
          child: Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(130),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
