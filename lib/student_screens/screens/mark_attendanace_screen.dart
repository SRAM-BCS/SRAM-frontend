import 'package:flutter/material.dart';
import 'package:summer_project/constants/constants.dart';

import '../widgets/cicular_ripple_button.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/mobile_gradient_background.jpg',
            ),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(
                '03:45 PM',
                style: TextStyle(
                  fontFamily: fontFamilySans,
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'Friday 30 June',
                style: TextStyle(
                  fontFamily: fontFamilySans,
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const CicularRippleButton(),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
